//
//  APIClient.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import Foundation

protocol APIClient {
  var session: URLSession { get }
  func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Response<T, APIError>) -> Void)
}

extension APIClient {
  typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
  
  private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
    
    let task = session.dataTask(with: request) { data, response, error in
      if let error = error as? URLError {
        switch error.code {
        case .networkConnectionLost:
          completion(nil, .connectionLost)
        case .notConnectedToInternet:
          completion(nil, .notConnectToInternet)
        default:
          completion(nil, .requestFailed)
          return
        }
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        completion(nil, .requestFailed)
        return
      }
      if httpResponse.statusCode == 200 {
        if let data = data {
          do {
            let genericModel = try JSONDecoder().decode(decodingType, from: data)
            completion(genericModel, nil)
          } catch {
            completion(nil, .jsonConversionFailure)
          }
        } else {
          completion(nil, .invalidData)
        }
      } else {
        completion(nil, .responseUnsuccessful)
      }
    }
    return task
  }
  
  func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Response<T, APIError>) -> Void) {
    let task = decodingTask(with: request, decodingType: T.self) { json, error in
      
      DispatchQueue.main.async {
        guard let json = json else {
          if let error = error {
            completion(Response.failure(error))
          } else {
            completion(Response.failure(.invalidData))
          }
          return
        }
        if let value = decode(json) {
          completion(.success(value))
        } else {
          completion(.failure(.jsonParsingFailure))
        }
      }
    }
    task.resume()
  }
}

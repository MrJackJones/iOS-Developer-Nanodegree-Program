//
//  Endpoint.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import Foundation

protocol Endpoint {
  var base: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
  var urlComponents: URLComponents {
    var components = URLComponents(string: base)!
    components.path = path
    
    if let queryItems = queryItems {
      components.queryItems = queryItems
    }
    
    return components
  }
  
  var request: URLRequest {
    let url = urlComponents.url!
    return URLRequest(url: url)
  }
}

enum StarWars {
  case getCharacters(page: Int)
  case getStarships(page: Int)
  case getVehicles(page: Int)
  case getCharacter(id: String)
  case getStarship(id: String)
  case getVehicle(id: String)
  case getPlanet(id: String)
}

extension StarWars: Endpoint {
  var base: String {
    return "https://swapi.co"
  }
  
  var path: String {
    switch self {
    case .getCharacters: return "/api/people"
    case .getStarships: return "/api/starships"
    case .getVehicles: return "/api/vehicles"
    case .getCharacter(let id): return "/api/people/\(id)"
    case .getStarship(let id): return "/api/starships/\(id)"
    case .getVehicle(let id): return "/api/vehicles/\(id)"
    case .getPlanet(let id): return "/api/planets/\(id)"
    }
  }
  
  var queryItems: [URLQueryItem]? {
    switch self {
    case .getCharacters(let page), .getVehicles(let page), .getStarships(let page):
      return [URLQueryItem(name: "page", value: "\(page)")]
    default:
      return nil
    }
  }
  
  
}

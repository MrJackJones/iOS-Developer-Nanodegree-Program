//
//  APIClient.swift
//  Virtual Tourist
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import Foundation
class APIClient {
    
    let session = URLSession.shared
    
    static let shared = APIClient()
    
    //constuct the Url from the parameters:
    
    private func buildUrlWithParam(parameters: [String: AnyObject]) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.Flickr.APIScheme
        urlComponents.host = Constants.Flickr.APIHost
        urlComponents.path = Constants.Flickr.APIBaseURL
        urlComponents.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems!.append(queryItem)
        }
        return urlComponents.url!
    }
    
    private func getParamPair(pin: Pin) -> Dictionary<String, Any> {
        return [
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.PhotosSearchMethod,
            Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
            Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
            Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
            Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback,
            Constants.FlickrParameterKeys.SafeSearch: Constants.FlickrParameterValues.SafeSearch,
Constants.FlickrParameterKeys.PerPage:Constants.FlickrParameterValues.PerPage,         
    Constants.FlickrParameterKeys.BoundingBox: getbbox(pin: pin)
        ]
    }
    
    //get boundingboxString
    private func getbbox(pin: Pin) -> String {
        // ensure boundingbox is bounded
        let minLong = max(pin.longitude - Constants.Flickr.SearchBoxWidth, Constants.Flickr.SearchLongRange.0)
        let minLat =  max(pin.latitude - Constants.Flickr.SearchBoxHeight, Constants.Flickr.SearchLatRange.0)
        let maxLong = min(pin.longitude + Constants.Flickr.SearchBoxWidth, Constants.Flickr.SearchLongRange.1)
        let maxLat = min(pin.latitude + Constants.Flickr.SearchBoxHeight, Constants.Flickr.SearchLatRange.1)
        
        return "\(minLong),\(minLat),\(maxLong),\(maxLat)"
    }
    
    //Create Request:
    func createRequest(pin: Pin) -> URLRequest {
         return URLRequest(url: buildUrlWithParam(parameters: getParamPair(pin: pin) as [String : AnyObject]))
    }
    
    //Perform the Request:
    func makeRequest(request: URLRequest, completionHandler: @escaping (_ result: NSArray?, _ error: String?) -> Void) {
        let task = session.dataTask(with: request) {
            (data, response, error) in
            //Request error
            guard(error == nil) else {
                completionHandler(nil, "Connection Error!")
                return
            }
            
            // successful http response
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, "Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                completionHandler(nil, "API data error occured!")
                return
            }
            
            // parse the result
            let parsedResult: [String: AnyObject]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
            } catch {
                completionHandler(nil, "Could not parse the data fromJSON: '\(data)'")
                return
            }
            
            //photos and photo key is present in the response:
            
            guard let photosDictionary = parsedResult?[Constants.FlickrResponseKeys.Photos] as? [String:AnyObject], let photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]] else {
                completionHandler(nil, "Cannot find Key : \(Constants.FlickrResponseKeys.Photos) in \(parsedResult!)")
                return
            }
            
            // image error:
            
            guard(photoArray.count > 0) else {
                completionHandler(nil, "No photos Found!.Try another search")
                return
            }
            
            
            completionHandler(photoArray as NSArray, nil)
        }
        
        task.resume()
    }
    
    //Download an Image:
    
    func downloadImage(imageUrl: String, completionHandler: @escaping (_ image: Data?,_ error: String?) -> Void ) {
        let task = session.dataTask(with: URL(string: imageUrl)!) {
            (data, response, error) in
            
            guard(error == nil) else {
                completionHandler(nil, "Connection Error!")
                return
            }
            
            // successful http response:
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, "Your request returned a status code other than 2xx!")
                return
            }
            
            completionHandler(data, nil)
            
        }
        task.resume()
    }
}

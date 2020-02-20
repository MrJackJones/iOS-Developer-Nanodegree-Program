//
//  StudentLocation.swift
//  OnTheMapND
//
//  Created by Maggie Mostrou on 17/1/20.
//  Copyright © 2020 Georgia M. Mostrou. All rights reserved.
//

struct StudentLocation: Codable {
    
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
}

//
//  StudentLocation.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
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

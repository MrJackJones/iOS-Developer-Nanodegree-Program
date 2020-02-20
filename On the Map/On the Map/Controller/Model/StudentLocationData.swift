//
//  StudentLocationData.swift
//  OnTheMapND
//
//  Created by Maggie Mostrou on 17/1/20.
//  Copyright © 2020 Georgia M. Mostrou. All rights reserved.
//

import MapKit

class StudentLocationData {
    
    static var allStudentLocation = [StudentLocation]()
    static var allStudentLocationPointAnnotation = [MKPointAnnotation]()
    
   
    static func setAllStudentLocationPointAnnotation() {
        for studentLocation in allStudentLocation {
            let firstName = studentLocation.firstName
            let lastName = studentLocation.lastName
            let mediaURL = studentLocation.mediaURL
            
            let latitude = CLLocationDegrees(studentLocation.latitude)
            let longitude = CLLocationDegrees(studentLocation.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.title = "\(firstName) \(lastName)"
            pointAnnotation.subtitle = mediaURL
            pointAnnotation.coordinate = coordinate
            
            allStudentLocationPointAnnotation.append(pointAnnotation)
        }
    }
}

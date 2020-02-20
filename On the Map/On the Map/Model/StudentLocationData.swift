//
//  StudentLocationData.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
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

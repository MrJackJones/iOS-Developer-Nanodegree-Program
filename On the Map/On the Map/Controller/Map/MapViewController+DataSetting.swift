//
//  MapViewController+DataSetting.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

extension MapViewController: DataSetting {
    
  
    
    func setViewData() {
        mapActivityIndicatorView.startAnimating()
        UdacityAPI.getAllStudentLocation(completionHandler: setViewData(dataCodable:))
    }
    
    func setViewData(dataCodable: Results?) {
        mapActivityIndicatorView.stopAnimating()
        
        guard let dataCodable = dataCodable else {
            displayAlert(title: "Internal error", message: "An error occurred, please try again later.")
            
            return
        }
        
        // Set all the Student Locations:
        StudentLocationData.allStudentLocation = dataCodable.results
        
        // Set all the annotations:
        StudentLocationData.setAllStudentLocationPointAnnotation()
        
        
        studentLocationMapView.addAnnotations(StudentLocationData.allStudentLocationPointAnnotation)
    }
    
    func refresh() {
        let annotations = studentLocationMapView.annotations
        studentLocationMapView.removeAnnotations(annotations)
        
        setViewData()
    }
}

//
//  MapViewController+MKMapViewDelegate.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//
import MapKit

extension MapViewController: MKMapViewDelegate {
    
   
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            // Display a view when clicking on a pin:
            annotationView!.canShowCallout = true
            
            // Add a detail button to the view:
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Open the student URL when clicking on the pin:
        
        let url = URL(string: (view.annotation!.subtitle!)!)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

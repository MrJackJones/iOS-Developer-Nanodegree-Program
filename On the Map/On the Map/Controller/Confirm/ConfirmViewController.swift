//
//  ConfirmViewController.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit
import MapKit

class ConfirmViewController: UIViewController {


    
    @IBOutlet weak var confirmMapView: MKMapView!
    @IBOutlet weak var confirmActivityIndicatorView: UIActivityIndicatorView!
    
    
    
    var locationData = [String: Any]()
    var url: String!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Confirm Your Location"
        
        setPointAnnotation()
    }
    
    
    @IBAction func addStudentLocation() {
        confirmActivityIndicatorView.startAnimating()
        
        UdacityAPI.addStudentLocation(
            mapString: locationData["location"] as! String,
            mediaURL: url,
            latitude: (locationData["coordinate"] as! CLLocationCoordinate2D).latitude,
            longitude: (locationData["coordinate"] as! CLLocationCoordinate2D).longitude,
            completionHandler: handleAddStudentLocationResponse(isPassed:)
        )
    }
    
    
    
    //Add a pin to the map:
    func setPointAnnotation() {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = locationData["location"] as? String
        pointAnnotation.coordinate = locationData["coordinate"] as! CLLocationCoordinate2D
        
        let coordinateRegion = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        
        confirmMapView.addAnnotation(pointAnnotation)
        confirmMapView.setRegion(coordinateRegion, animated: true)
    }
    
   
    func handleAddStudentLocationResponse(isPassed: Bool) {
        guard isPassed else {
            displayAlert(title: "Internal error", message: "An error occurred, please try again later.")
            
            return
        }
        
        confirmActivityIndicatorView.stopAnimating()
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
}

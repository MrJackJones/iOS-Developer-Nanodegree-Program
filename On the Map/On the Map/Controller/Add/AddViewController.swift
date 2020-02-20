//
//  AddViewController.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit
import MapKit

class AddViewController: UIViewController {
    
   
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var addLoginIndicatorView: UIActivityIndicatorView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTapGestureRecognizer()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let confirmViewController = segue.destination as! ConfirmViewController
        confirmViewController.locationData = sender as! [String: Any]
        confirmViewController.url = urlTextField.text
    }
    
    
    
    //Search the location from the user input.
    @IBAction func findLocation() {
        let location = locationTextField.text!
        let url = urlTextField.text!
        
        guard !location.isEmpty, !url.isEmpty else {
            displayAlert(title: "Empty field", message: "Please fill location and URL.")
            
            return
        }
        
        addLoginIndicatorView.startAnimating()
        CLGeocoder().geocodeAddressString(location, completionHandler: handleGeocodeAddressString(placemarks:error:))
    }
    
   
    
   
    func handleGeocodeAddressString(placemarks: [CLPlacemark]?, error: Error?) {
        addLoginIndicatorView.stopAnimating()
        
        guard error == nil else {
            let errorCode = (error as NSError?)!.code
            if errorCode == 8 {
                displayAlert(title: "Failed to find location", message: "Please enter a correct location.")
            } else {
                print(error!.localizedDescription)
                displayAlert(title: "Internal error", message: "An error occurred, please try again later.")
            }
            
            return
        }
        
        let placemark = placemarks!.first!
        let locationData: [String: Any] = [
            "location": placemark.locality!,
            "coordinate": placemark.location!.coordinate
        ]
        performSegue(withIdentifier: "confirmLocation", sender: locationData)
    }
}

//
//  MapViewController.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//
import UIKit
import MapKit

class MapViewController: UIViewController {

   
    
    @IBOutlet weak var studentLocationMapView: MKMapView!
    @IBOutlet weak var mapActivityIndicatorView: UIActivityIndicatorView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewData()
    }
    
    
    
    //Refresh  mapView:
    @IBAction func refreshAction() {
        refresh()
    }
}

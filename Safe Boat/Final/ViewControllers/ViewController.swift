//
//  ViewController.swift
//  Final
//
//  Created by Ivan on 18.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation
import  AVFoundation

class ViewController: UIViewController, AlertProtocol, CLLocationManagerDelegate {
    @IBOutlet weak var setLocationSourceBarItem: UIBarButtonItem!
    @IBOutlet weak var gpsButton: UIBarButtonItem!
    @IBOutlet weak var collisionMessage: UILabel!
    @IBOutlet weak var headingSpeedStackView: UIStackView!
    @IBOutlet weak var myLocation: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var headingSlider: UISlider!
    @IBOutlet weak var mapView: MKMapView!

    var  locationManager: CLLocationManager?
    var dataController:DataController!
    var center:CLLocationCoordinate2D!
    var fetchedResultsController: NSFetchedResultsController<Boat>!
    var heading:Int = 0
    var speed: Int = 20
    var gpsEnabled:Bool = false
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        ifFirstRun()
        redrawPins()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            gpsButton.isEnabled = true
        } else {
            gpsButton.isEnabled = false
        }
    }
    
    @IBAction func selectLocationSource(_ sender: Any) {
        if gpsEnabled {
            gpsEnabled = false
            gpsButton.image = UIImage(systemName: "safari.fill")
            alert(title: "Manual mode", message: "You enabled manual mode. Move the map to set your current location.\r\nUse the sliders to set the heading and the speed.")
            mapView.isScrollEnabled = true
            mapView.isZoomEnabled = true
            headingSpeedStackView.isHidden = false
        } else {
            alert(title: "GPS mode", message: "You enabled GPS mode. Your current location will be used.")
            gpsEnabled = true
            gpsButton.image = nil
            gpsButton.image = UIImage(systemName:  "safari")
            mapView.isScrollEnabled = false
            mapView.isZoomEnabled = false
            headingSpeedStackView.isHidden = true
            locationManager?.startUpdatingLocation()
            locationManager?.startUpdatingHeading()
           
        }
    }
    
    @IBAction func setupApiKey(_ sender: Any) {
        let alertBox = UIAlertController(title: "Welcome", message: "Please enter your API Key. If you are evaluating the Udacity submission, you will find the API Key in the submission details.", preferredStyle: .alert)
        alertBox.addTextField { (textField) in
            textField.text = ""
        }
        alertBox.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alertBox] (_) in
            let textField = alertBox?.textFields![0] // Force unwrapping because we know it exists.
            if textField?.text?.count == 0 {
                if !UserDefaults.standard.bool(forKey: "hasValidApiKey") { // Ask for the API key.
                    self.setupApiKey(self)
                } else {
                    self.alert(title:"Warning!",message: "Key not changed!")
                }
            } else {
                UserDefaults.standard.set(true, forKey: "hasValidApiKey")
                UserDefaults.standard.set(textField?.text, forKey: "apiKey")
                UserDefaults.standard.synchronize()
            }
            }
            )
        )
        self.present(alertBox, animated: true, completion: nil)
    }

    @IBAction func autoRefreshData(_ sender: Any) {
        if setLocationSourceBarItem.image == UIImage(systemName: "mappin.and.ellipse") {
            setLocationSourceBarItem.image = UIImage(systemName: "mappin.slash")
            timer = nil
            locationManager?.stopUpdatingLocation()
            locationManager?.stopUpdatingHeading()
            alert(title: "Offline mode", message: "The last boats will be displayed, their location will not be updated. ")
        } else {
            setLocationSourceBarItem.image = UIImage(systemName: "mappin.and.ellipse")
            alert(title: "Online mode", message: "Real time boat data is downloaded from the internet every two minutes." )
            timer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true) { timer in
                self.refreshData(self) // The marinetraffic API updates the data every 120 seconds.
                self.redrawPins()
            }
        }
    }
    
    @IBAction func refreshData(_ sender: Any) {
        let corner1 = MKMapPoint(x: mapView.visibleMapRect.minX, y:mapView.visibleMapRect.minY).coordinate
        let corner2 = MKMapPoint(x: mapView.visibleMapRect.maxX, y: mapView.visibleMapRect.maxY).coordinate
        NetworkClient.GetBoatsInArea(minLatitude: corner2.latitude    , maxLatitude: corner1.latitude, minLongitude: corner1.longitude, maxLongitude: corner2.longitude, dataController: dataController, completion: downloadDataHandler)
    }
    
    @IBAction func updateMyBoat(_ sender: Any) {
        speed = Int(speedSlider.value)
        heading = Int(headingSlider.value)
        headingLabel.text = "Heading: \(heading)"
        speedLabel.text = "Speed: \(Float(speed))"
        myLocation.transform = CGAffineTransform.identity.rotated(by: CGFloat(Float(heading) * Float.pi/180))
        redrawPins()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayBoatsListSegue" {
            let boatsListVC = segue.destination as! ListViewController
            boatsListVC.dataController = dataController
        }
    }
    
    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let longitudeG = locations.last?.coordinate.longitude ?? CLLocationDegrees(27)
        let latitudeG = locations.last?.coordinate.latitude ?? CLLocationDegrees(38)
        center = CLLocationCoordinate2D(latitude: latitudeG , longitude: longitudeG)
        mapView.setCenter(center, animated: true)

        redrawPins()
    }
}

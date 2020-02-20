//
//  TableViewController+DataSetting.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

extension TableViewController: DataSetting {
    
   
    
    func setViewData() {
        tableActivityIndicatorView.startAnimating()
        UdacityAPI.getAllStudentLocation(completionHandler: setViewData(dataCodable:))
    }
    
    func setViewData(dataCodable: Results?) {
        tableActivityIndicatorView.stopAnimating()
        
        guard let dataCodable = dataCodable else {
            displayAlert(title: "Internal error", message: "An error occurred, please try again later.")
            
            return
        }
        
        // Set all the StudentLocations:
        StudentLocationData.allStudentLocation = dataCodable.results
        
        // RefreshtableView:
        studentLocationTableView.reloadData()
    }
    
    func refresh() {
        StudentLocationData.allStudentLocation.removeAll()
        studentLocationTableView.reloadData()
        
        setViewData()
    }
}

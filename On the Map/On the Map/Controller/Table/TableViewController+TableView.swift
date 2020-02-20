//
//  TableViewController+TableView.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocationData.allStudentLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentLocationCell", for: indexPath)
        let studentLocation = StudentLocationData.allStudentLocation[indexPath.row]
        
        cell.textLabel!.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.detailTextLabel!.text = studentLocation.mediaURL
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocationURL = StudentLocationData.allStudentLocation[indexPath.item].mediaURL
        
        guard let url = URL(string: studentLocationURL) else {
            displayAlert(title: "Invalid URL", message: "")
            
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

//
//  Extensions.swift
//  Virtual Tourist
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//
import UIKit

extension UIViewController {
    //alert message
    func showAlertMessage(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

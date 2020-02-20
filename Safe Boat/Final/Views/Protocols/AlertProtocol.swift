//
//  AlertProtocol.swift
//  Final
//
//  Created by Ivan on 18.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit


protocol AlertProtocol {
    func alert(title:String, message:String)
    func alert (message:String)
}

extension AlertProtocol where Self:UIViewController{
    func alert(title:String, message:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("Error: \(message)")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func alert(message:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("Error: \(message)")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
  
}

//
//  AddViewController+UITextFieldDelegate.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//
import UIKit

extension AddViewController: UITextFieldDelegate {
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == locationTextField {
            urlTextField.becomeFirstResponder()
        }
        
        return true
    }
}

//
//  LoginViewController.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpTextView: UITextView!
    @IBOutlet weak var loginActivityIndicatorView: UIActivityIndicatorView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSignUpTextView()
        setTapGestureRecognizer()
    }
    
    
    
    //Check email and password using the  API:
    @IBAction func logIn() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        guard !email.isEmpty, !password.isEmpty else {
            displayAlert(title: "Empty field", message: "Please fill-in email and password.")
            
            return
        }
        
        loginActivityIndicatorView.startAnimating()
        UdacityAPI.addSession(email: email, password: password, completionHandler: handleSessionResponse(jsonData:))
    }
    
   
    
    //Set the sign up:
    func setSignUpTextView() {
        let attributedString = NSMutableAttributedString(string: signUpTextView.text)
    
        // Set the "Sign up." substring to be the link
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")!
        attributedString.setAttributes([.link: url], range: NSMakeRange(23, 8))
        
        signUpTextView.attributedText = attributedString
        signUpTextView.textAlignment = NSTextAlignment.center
    }
    
   
    func handleSessionResponse(jsonData: [String: Any]?) {
        loginActivityIndicatorView.stopAnimating()
        
        guard let jsonData = jsonData else {
            displayAlert(title: "Internal error", message: "An error occurred, please try again later.")
            
            return
        }
        
        guard jsonData["error"] == nil else {
            displayAlert(title: "Login failed", message: "Incorrect email and/or password.")
            
            return
        }
        
        performSegue(withIdentifier: "successfulLogin", sender: nil)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}

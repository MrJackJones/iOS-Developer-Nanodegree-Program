//
//  Spinner.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import UIKit

class Spinner: UIView {
  
  let activityIndicator = UIActivityIndicatorView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSpinner()
  }
  
  convenience init() {
    self.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  func setupSpinner() {
    self.center =  CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
    self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    self.clipsToBounds = true
    self.layer.cornerRadius = 10
    self.isHidden = true
    
    activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    activityIndicator.style = .whiteLarge
    activityIndicator.color = .white
    activityIndicator.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
    activityIndicator.hidesWhenStopped = true
    
    self.addSubview(activityIndicator)
  }
  
  func start() {
    UIApplication.shared.beginIgnoringInteractionEvents()
    self.isHidden = false
    activityIndicator.startAnimating()
  }
  
  func stop() {
    UIApplication.shared.endIgnoringInteractionEvents()
    self.isHidden = true
    activityIndicator.stopAnimating()
  }
}

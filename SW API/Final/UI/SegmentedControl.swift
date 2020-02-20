//
//  SegmentedControl.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit

class SegmentedControl: UISegmentedControl {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    configure()
  }
  
  func configure() {
    setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)], for: .normal)
    
    setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
  }
  
  @IBInspectable var fontSize: CGFloat = 0.0 {
    didSet {
      setTitleTextAttributes([
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: .regular),
        NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
        ], for: .normal)
      
      setTitleTextAttributes([
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: .bold),
        NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .selected)
    }
  }
}

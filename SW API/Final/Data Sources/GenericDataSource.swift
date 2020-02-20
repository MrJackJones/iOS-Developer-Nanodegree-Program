//
//  GenericDataSource.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import UIKit

class GenericDataSource<T>: NSObject, UIPickerViewDataSource {
  private var collection: [T]
  
  init(collection: [T]) {
    self.collection = collection
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return collection.count
  }
  
  func update(with collection: [T]) {
    self.collection = collection
  }
}

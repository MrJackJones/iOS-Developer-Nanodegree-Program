//
//  DetailStarwarsResourcesController+UIPickerViewDelegate.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import UIKit

extension DetailStarwarsResourcesController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if let resourceType = resourceType {
      switch resourceType {
      case .characters: return self.characters[row].name
      case .starships: return self.starships[row].name
      case .vehicles: return self.vehicles[row].name
      }
    }
    return nil
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if let resourceType = resourceType {
      switch resourceType {
      case .characters:
        let id = self.characters[row].idByURL
        getCharacter(byId: id)
        
        if self.characters.count-1 == row && row < charactersCount-1 {
          let page = row % 9 + 2
          getCharacters(byPage: page)
        }
      case .starships:
        let id = self.starships[row].idByURL
        getStarship(byId: id)
        
        if self.starships.count-1 == row && row < starshipsCount-1 {
          let page = row % 9 + 2
          getStarhips(byPage: page)
        }
      case .vehicles:
        let id = self.vehicles[row].idByURL
        getVehicle(byId: id)
        
        if self.vehicles.count-1 == row && row < vehiclesCount-1 {
          let page = row % 9 + 2
          getVehicles(byPage: page)
        }
      }
    }
  }
  
}

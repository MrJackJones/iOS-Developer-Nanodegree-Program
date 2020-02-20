//
//  CharacterViewModel.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import Foundation

struct CharacterViewModel {
  let name: String
  let birthYear: String
  let homeWorld: String
  let height: String
  let eyeColor: String
  let hairColor: String
  let starships: String
  let vehicles: String
  
}

extension CharacterViewModel {
  init(character: Character, planetName: String, vehiclesName: String, starshipsName: String) {
    self.name = character.name
    self.birthYear = character.birthYear
    self.homeWorld = planetName
    self.height = character.height
    self.eyeColor = character.eyeColor
    self.hairColor = character.hairColor
    self.starships = starshipsName
    self.vehicles = vehiclesName
  }
}

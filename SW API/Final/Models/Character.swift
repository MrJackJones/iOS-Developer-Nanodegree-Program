//
//  Character.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import Foundation

struct Character: Codable {
  let name: String
  let birthYear: String
  let homeWorld: URL
  let height: String
  let eyeColor: String
  let hairColor: String
  let starships: [URL]
  let vehicles: [URL]
  let url: URL
  
  enum CodingKeys: String, CodingKey {
    case name
    case birthYear = "birth_year"
    case homeWorld = "homeworld"
    case height
    case eyeColor = "eye_color"
    case hairColor = "hair_color"
    case starships
    case vehicles
    case url
  }
}

extension Character {
  var idByURL: String {
    return url.lastPathComponent
  }
  
  var idWorldByURL: String {
    return homeWorld.lastPathComponent
  }
  
  var idVehiclesByURL: [String] {
    var ids: [String] = []
    for vehicle in vehicles {
      ids.append(vehicle.lastPathComponent)
    }
    return ids
  }
  
  var idStarshipsByURL: [String] {
    var ids: [String] = []
    for starship in starships {
      ids.append(starship.lastPathComponent)
    }
    return ids
  }
  
}

struct CharacterResult: Codable {
  let count: Int
  let results: [Character]?
}

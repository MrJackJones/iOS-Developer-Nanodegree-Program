//
//  Starship.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import Foundation

struct Starship: Codable, TransportCraft {
  var name: String
  var manufacturer: String
  var costInCredits: String
  var length: String
  var ´class´: String
  var crew: String
  var url: URL
  
  enum CodingKeys: String, CodingKey {
    case name
    case manufacturer
    case costInCredits = "cost_in_credits"
    case length
    case ´class´ = "starship_class"
    case crew
    case url
  }
}

struct StarshipResult: Codable {
  let count: Int
  let results: [Starship]?
}

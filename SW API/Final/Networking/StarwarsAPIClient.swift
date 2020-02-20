//
//  StarwarsAPIClient.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import Foundation

class StarwarsAPIClient: APIClient {
  let session: URLSession
  
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  convenience init() {
    self.init(configuration: .default)
  }
  
  // Characters:
  typealias CharactersCompletionHandler = (Response<CharacterResult?, APIError>) -> Void
  func getCharacters(byPage page: Int = 1, completion: @escaping CharactersCompletionHandler) {
    let request = StarWars.getCharacters(page: page).request
    
    fetch(with: request , decode: { json -> CharacterResult? in
      guard let charactersResult = json as? CharacterResult else { return  nil }
      return charactersResult
    }, completion: completion)
  }
  
  typealias CharacterCompletionHandler = (Response<Character?, APIError>) -> Void
  func getCharacter(withId id: String, completion: @escaping CharacterCompletionHandler) {
    let request = StarWars.getCharacter(id: id).request
    
    fetch(with: request , decode: { json -> Character? in
      guard let characterResult = json as? Character else { return  nil }
      
      return characterResult
    }, completion: completion)
  }
  
  //Vehicles:
  typealias VehiclesCompletionHandler = (Response<VehicleResult?, APIError>) -> Void
  func getVehicles(byPage page: Int = 1, completion: @escaping VehiclesCompletionHandler) {
  let request = StarWars.getVehicles(page: page).request
    
    fetch(with: request , decode: { json -> VehicleResult? in
      guard let vehiclesResult = json as? VehicleResult else { return  nil }
      return vehiclesResult
    }, completion: completion)
  }
  
  typealias VehicleCompletionHandler = (Response<Vehicle?, APIError>) -> Void
  func getVehicle(withId id: String, completion: @escaping VehicleCompletionHandler) {
    let request = StarWars.getVehicle(id: id).request
    
    fetch(with: request , decode: { json -> Vehicle? in
      guard let vehicleResult = json as? Vehicle else { return  nil }
      return vehicleResult
    }, completion: completion)
  }
  
  typealias VehiclesByCharacterCompletionHandler = (Response<[String]?, APIError>) -> Void
  func getVehicles(byIds ids: [String], completion: @escaping VehiclesByCharacterCompletionHandler)  {
    let group = DispatchGroup()
    
    var vehiclesName = [String]()
    
    for id in ids {
      group.enter()
      
      getVehicle(withId: id) { response in
        group.leave()
        switch response {
        case .success(let vehicle):
          guard let vehicle = vehicle else { return }
          vehiclesName.append(vehicle.name)
        case .failure(let error):
          completion(Response.failure(error))
        }
      }
    }
    
    group.notify(queue: .main) {
      completion(Response.success(vehiclesName))
    }
  }
  
  
  //Starships
  typealias StarshipsCompletionHandler = (Response<StarshipResult?, APIError>) -> Void
  func getStarships(byPage page: Int, completion: @escaping StarshipsCompletionHandler) {
    let request = StarWars.getStarships(page: page).request
    
    fetch(with: request , decode: { json -> StarshipResult? in
      guard let starshipsResult = json as? StarshipResult else { return  nil }
      return starshipsResult
    }, completion: completion)
  }
  
  typealias StarshipCompletionHandler = (Response<Starship?, APIError>) -> Void
  func getStarship(withId id: String, completion: @escaping StarshipCompletionHandler) {
    let request = StarWars.getStarship(id: id).request
    
    fetch(with: request , decode: { json -> Starship? in
      guard let starshipResult = json as? Starship else { return  nil }
      return starshipResult
    }, completion: completion)
  }
  
  typealias StarshipsByCharacterCompletionHandler = (Response<[String]?, APIError>) -> Void
  func getStarshipsName(byIds ids: [String], completion: @escaping StarshipsByCharacterCompletionHandler)  {
    let group = DispatchGroup()
    
    var starshipsName = [String]()
    
    for id in ids {
      group.enter()
      
      getStarship(withId: id) { response in
        group.leave()
        switch response {
        case .success(let starship):
          guard let starship = starship else { return }
          starshipsName.append(starship.name)
        case .failure(let error):
          completion(Response.failure(error))
        }
      }
    }
    
    group.notify(queue: .main) {
      completion(Response.success(starshipsName))
    }
  }
  
  //Planets:
  typealias PlanetCompletionHanler = (Response<Planet?, APIError>) -> Void
  func getPlanet(withId id: String, completion: @escaping PlanetCompletionHanler) {
    let request = StarWars.getPlanet(id: id).request
    
    fetch(with: request , decode: { json -> Planet? in
      guard let planetResult = json as? Planet else { return  nil }
      return planetResult
    }, completion: completion)
  }
  
}

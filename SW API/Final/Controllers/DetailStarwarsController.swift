//
//  DetailStarwarsController.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit

class DetailStarwarsResourcesController: UITableViewController {
  
  @IBOutlet weak var labelOne: UILabel!
  @IBOutlet weak var labelTwo: UILabel!
  @IBOutlet weak var labelThree: UILabel!
  @IBOutlet weak var labelFour: UILabel!
  @IBOutlet weak var labelFive: UILabel!
  
  @IBOutlet weak var valueOne: UILabel!
  @IBOutlet weak var valueTwo: UILabel!
  @IBOutlet weak var valueThree: UILabel!
  @IBOutlet weak var valueFour: UILabel!
  @IBOutlet weak var valueFive: UILabel!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var costSegmentedControl: SegmentedControl!
  @IBOutlet weak var lengthSegmentedControl: SegmentedControl!
  
  var selectedCostType: String {
    return costSegmentedControl.titleForSegment(at: costSegmentedControl.selectedSegmentIndex)!
  }
  
  var selectedLengthType: String {
    return lengthSegmentedControl.titleForSegment(at: lengthSegmentedControl.selectedSegmentIndex)!
  }
  
  @IBOutlet weak var vehiclesLabel: UILabel!
  @IBOutlet weak var vehiclesValue: UILabel!
  
  @IBOutlet weak var starshipsLabel: UILabel!
  @IBOutlet weak var starshipsValue: UILabel!
  
  @IBOutlet weak var separatorView: UIView!
  
  @IBOutlet weak var pickerView: UIPickerView!
  
  @IBOutlet weak var smallestLabel: UILabel!
  @IBOutlet weak var largestLabel: UILabel!
  
  @IBOutlet weak var exchangeRateTextField: UITextField!
  
  let client = StarwarsAPIClient()
  
  var charactersDataSource = GenericDataSource<Character>(collection: [])
  var characters: [Character] = [] {
    didSet {
      self.charactersDataSource.update(with: characters)
      self.pickerView.reloadAllComponents()
      let sortedCharacters = sort(characters, by: \.height)
      if let min = sortedCharacters.first, let max = sortedCharacters.last {
        smallestLabel.text = min.name
        largestLabel.text = max.name
      }
    }
  }
  var charactersCount = Int()
  
  var vehiclesDataSource = GenericDataSource<Vehicle>(collection: [])
  var vehicles: [Vehicle] = [] {
    didSet {
      self.vehiclesDataSource.update(with: vehicles)
      self.pickerView.reloadAllComponents()
      let sortedVehicles = sort(vehicles, by: \.length)
      if let min = sortedVehicles.first, let max = sortedVehicles.last {
        smallestLabel.text = min.name
        largestLabel.text = max.name
      }
    }
  }
  var vehiclesCount = Int()
  
  var starshipsDataSource = GenericDataSource<Starship>(collection: [])
  var starships: [Starship] = [] {
    didSet {
      self.starshipsDataSource.update(with: starships)
      self.pickerView.reloadAllComponents()
      let sortedStarships = sort(starships, by: \.length)
      if let min = sortedStarships.first, let max = sortedStarships.last {
        smallestLabel.text = min.name
        largestLabel.text = max.name
      }
    }
  }
  var starshipsCount = Int()
  
  var resourceType: ResourceType?
  
  let spinner = Spinner()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Picker View Delegate
    pickerView.delegate = self
    
    //Sets spinner
    self.view.addSubview(spinner)
    
    if let resourceType = resourceType {
      self.navigationItem.title = resourceType.rawValue
      configureUI(withResourceType: resourceType)
      populatePicker(withResourceType: resourceType)
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Custom Snippet Pasan Slack
  func sort<T, U: Comparable>(_ values: [T], by keyPath: KeyPath<T, U>) -> [T] {
    return values.sorted(by: {
      if let firstString = $0[keyPath: keyPath] as? String, let firstDouble = Double(firstString), let secondString = $1[keyPath: keyPath] as? String, let secondDouble = Double(secondString) {
        return firstDouble < secondDouble
      }
      return false
    })
  }
  
  func configureUI(withResourceType resourceType: ResourceType) {
    switch resourceType {
    case .characters:
      labelOne.text = "Born"
      labelTwo.text = "Home"
      labelThree.text = "Height"
      labelFour.text = "Eyes"
      labelFive.text = "Hair"
      costSegmentedControl.isHidden = true
    case .starships, .vehicles:
      labelOne.text = "Make"
      labelTwo.text = "Cost"
      labelThree.text = "Lenght"
      labelFour.text = "Class"
      labelFive.text = "Crew"
      vehiclesLabel.isHidden = true
      vehiclesValue.isHidden = true
      starshipsLabel.isHidden = true
      starshipsValue.isHidden = true
      separatorView.isHidden = true
    }
  }
  
  func populatePicker(withResourceType resourceType: ResourceType) {
    switch resourceType {
    case .characters:
      pickerView.dataSource = charactersDataSource
      getCharacters(byPage: 1)
    case .starships:
      pickerView.dataSource = starshipsDataSource
      getStarhips(byPage: 1)
    case .vehicles:
      pickerView.dataSource = vehiclesDataSource
      getVehicles(byPage: 1)
    }
  }
  
  func getCharacters(byPage page: Int) {
    spinner.start()
    client.getCharacters(byPage: page) { [unowned self] response in
      self.spinner.stop()
      switch response {
      case .success(let characters):
        guard let count = characters?.count, let characters = characters?.results else { return }
        self.characters.append(contentsOf: characters)
        self.charactersCount = count
        
        if self.characters.count <= 10 {
          guard let firstCharacter = characters.first else { return }
          self.getCharacter(byId: firstCharacter.idByURL)
        }
      case .failure(let error):
        self.presentAlert(withMessage: error.rawValue)
      }
    }
  }
  
  func getStarhips(byPage page: Int) {
    spinner.start()
    client.getStarships(byPage: page) { [unowned self] response in
      self.spinner.stop()
      switch response {
      case .success(let starships):
        guard let count = starships?.count, let starships = starships?.results else { return }
        self.starships.append(contentsOf: starships)
        self.starshipsCount = count
        
        if self.starships.count <= 10 {
          guard let firstStarship = self.starships.first else { return }
          self.getStarship(byId: firstStarship.idByURL)
        }
      case .failure(let error):
        self.presentAlert(withMessage: error.rawValue)
      }
    }
  }
  
  func getVehicles(byPage page: Int) {
    spinner.start()
    client.getVehicles(byPage: page) { [unowned self] response in
      self.spinner.stop()
      switch response {
      case .success(let vehicles):
        guard let count = vehicles?.count, let vehicles = vehicles?.results else { return }
        self.vehicles.append(contentsOf: vehicles)
        self.vehiclesCount = count
        
        if self.vehicles.count <= 10 {
          guard let firstVehicle = self.vehicles.first else { return }
          self.getVehicle(byId: firstVehicle.idByURL)
        }
      case .failure(let error):
        self.presentAlert(withMessage: error.rawValue)
      }
    }
  }
  
  func getCharacter(byId id: String) {
    spinner.start()
    client.getCharacter(withId: id) { [unowned self] response in
      self.resetSegmentedControls()
      switch response {
      case .success(let character):
        guard let character = character else { return }
        self.getOtherInfo(byCharacter: character)
      case .failure(let error):
        self.presentAlert(withMessage: error.rawValue)
      }
    }
  }
  
  func getOtherInfo(byCharacter character: Character) {    
    var planetName = String()
    var vehiclesName = String()
    var starshipsName = String()
    
    let group = DispatchGroup()
    
    group.enter()
    client.getPlanet(withId: character.idWorldByURL) { response in
      group.leave()
      switch response {
      case .success(let planet):
        guard let planet = planet else { return }
        planetName = planet.name
      case .failure(let error):
        self.presentAlert(withMessage: error.rawValue)
      }
    }
    
    let collectionIdVehicles = character.idVehiclesByURL
    if !collectionIdVehicles.isEmpty {
      group.enter()
      client.getVehicles(byIds: collectionIdVehicles) { response in
        group.leave()
        switch response {
        case .success(let names):
          guard let names = names else { return }
          vehiclesName =  names.joined(separator: " - ")
        case .failure(let error):
          self.presentAlert(withMessage: error.rawValue)
        }
      }
    }
    
    let collectionIdStarships = character.idStarshipsByURL
    if !collectionIdStarships.isEmpty {
      group.enter()
      client.getStarshipsName(byIds: collectionIdStarships) { response in
        group.leave()
        switch response {
        case .success(let names):
          guard let names = names else { return }
          starshipsName =  names.joined(separator: " - ")
        case .failure(let error):
          self.presentAlert(withMessage: error.rawValue)
        }
      }
    }
    
    group.notify(queue: .main) {
      let characterViewModel = CharacterViewModel(character: character, planetName: planetName, vehiclesName: vehiclesName, starshipsName: starshipsName)
      self.populateQuickBar(byResource: characterViewModel)
      self.spinner.stop()
    }

  }
  
  func getStarship(byId id: String) {
    spinner.start()
    client.getStarship(withId: id) { response in
      self.spinner.stop()
      self.resetSegmentedControls()
      switch response {
      case .success(let starship):
        guard let starship = starship else { return }
        self.populateQuickBar(byResource: starship)
      case .failure(let error):
        self.presentAlert(withMessage: error.rawValue)
      }
    }
  }
  
  func getVehicle(byId id: String) {
    spinner.start()
    client.getVehicle(withId: id) { response in
      self.spinner.stop()
      self.resetSegmentedControls()
      switch response {
      case .success(let vehicle):
        guard let vehicle = vehicle else { return }
        self.populateQuickBar(byResource: vehicle)
      case .failure(let error):
        self.presentAlert(withMessage: error.rawValue)
      }
    }
  }
  
  func resetSegmentedControls() {
    lengthSegmentedControl.selectedSegmentIndex = 1
    costSegmentedControl.selectedSegmentIndex = 1
  }
  
  func populateQuickBar(byResource resource: Any) {
    switch resource {
    case let resource as CharacterViewModel:
      nameLabel.text = resource.name
      valueOne.text = resource.birthYear
      valueTwo.text = resource.homeWorld
      valueThree.text = resource.height
      valueFour.text = resource.eyeColor
      valueFive.text = resource.hairColor
      vehiclesValue.text = resource.vehicles
      starshipsValue.text = resource.starships
    case let resource as TransportCraft:
      nameLabel.text = resource.name
      valueOne.text = resource.manufacturer
      valueTwo.text = resource.costInCredits
      valueThree.text = resource.length
      valueFour.text = resource.´class´
      valueFive.text = resource.crew
    default:
      break
    }
  }
  
  @IBAction func convertCost() {
    if let exchangeRateString = exchangeRateTextField.text, let exchangeRateDouble = Double(exchangeRateString), let cost = valueTwo.text, let costDouble = Double(cost), exchangeRateDouble > 0 {
      if selectedCostType == "USD" {
        let value = costDouble * exchangeRateDouble
        valueTwo.text = String(value)
      } else {
        let value = costDouble / exchangeRateDouble
        valueTwo.text = String(value)
      }
    } else {
      presentAlert(withMessage: "Cost Converter Error")
    }
  }
  
  
  @IBAction func convertHeight() {
    if let string = valueThree.text, let height = Double(string) {
      var unitMetric = UnitLength.meters
      if let resourceType = resourceType {
        if resourceType == .characters { unitMetric = UnitLength.centimeters }
      }
      if selectedLengthType == "English" {
        let value = Measurement(value: height, unit: unitMetric).converted(to: UnitLength.inches).value.rounded(toPlaces: 2)
        valueThree.text = String(value)
      } else {
        let value = Measurement(value: height, unit: UnitLength.inches).converted(to: unitMetric).value.rounded(toPlaces: 2)
        valueThree.text = String(value)
      }
    } else {
      presentAlert(withMessage: "Converter Error")
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0: return 310
    case 1:
      if let resourceType = resourceType {
        return resourceType == .characters ? 0 : 60
      }
    case 2: return 160
    case 3: return 60
    default: break
    }
    return 60
  }
  
  func presentAlert(withMessage message: String) {
    let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
    
    self.present(alertController, animated: true, completion: nil)
  }
  
}







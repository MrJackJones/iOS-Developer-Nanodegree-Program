//
//  CreateTestData.swift
//  Final
//
//  Created by Ivan on 18.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import Foundation
import CoreData
class CreateCoreData {
    func CreateTestData (dataController:DataController){
        
        let testString = """
                 [{"MMSI":"563080200","IMO":"9839014","SHIP_ID":"5865745","LAT":"23.97116","LON":"-29.21107","SPEED":"74","HEADING":"329","COURSE":"327","≈":"0","TIMESTAMP":"2020-01-19T09:39:57","DSRC":"TER","UTC_SECONDS":"54"},{"MMSI":"563080200","IMO":"9839014","SHIP_ID":"5865745","LAT":"23.97116","LON":"-29.21107","SPEED":"122","HEADING":"162","COURSE":"157","STATUS":"0","TIMESTAMP":"2020-01-19T09:44:27","DSRC":"TER","UTC_SECONDS":"28"},{"MMSI":"636017367","IMO":"9710581","SHIP_ID":"3734546","LAT":"21.54414","LON":"-28.18893","SPEED":"79","HEADING":"316","COURSE":"311","STATUS":"0","TIMESTAMP":"2020-01-19T09:43:53","DSRC":"TER","UTC_SECONDS":"52"}]
                 """.data(using: .utf8)

                 let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Boat")
                           fetch.predicate = NSPredicate(value: true)
                           let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
                           let _ = try? dataController.viewContext.execute(deleteRequest)
        
                    do {
                     let boats = try JSONDecoder().decode([BoatStruct].self, from: testString!)
                            
                     for boat in boats{
                                  let newBoat = Boat(context: dataController.viewContext)
                                  newBoat.course = boat.course
                                  newBoat.dsrc = boat.dsrc
                                  newBoat.heading = boat.heading
                                  newBoat.imo = boat.imo
                                  newBoat.latitude = boat.latitude
                                  newBoat.longitude = boat.longitude
                                  newBoat.mmsi = boat.mmsi
                                  newBoat.boatId = boat.boatId
                                  newBoat.speed = boat.speed
                                  newBoat.status = boat.status
                                  newBoat.timeStamp = boat.timeStamp
                                  newBoat.utcSeconds = boat.utcSeconds
                                  try? dataController.viewContext.save()
                              }

                     } catch DecodingError.dataCorrupted(let context) {
                         print(context)
                     } catch DecodingError.keyNotFound(let key, let context) {
                         print("Key '\(key)' not found:", context.debugDescription)
                         print("codingPath:", context.codingPath)
                     } catch DecodingError.valueNotFound(let value, let context) {
                         print("Value '\(value)' not found:", context.debugDescription)
                         print("codingPath:", context.codingPath)
                     } catch DecodingError.typeMismatch(let type, let context)  {
                         print("Type '\(type)' mismatch:", context.debugDescription)
                         print("codingPath:", context.codingPath)
                     } catch {
                         print("error: ", error)
                     }
       }
}

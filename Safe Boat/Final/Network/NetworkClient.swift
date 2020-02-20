//
//  NetworkClient.swift
//  Final
//
//  Created by Ivan on 18.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class NetworkClient {
    static var apiKey: String = ""
    
    class func GetBoatsInArea(minLatitude: Double, maxLatitude: Double, minLongitude: Double, maxLongitude: Double, timespan:Int? = 0, dataController:DataController, completion: @escaping (Bool, String?)->Void) {
        apiKey = UserDefaults.standard.string(forKey: "apiKey")!
        let baseURL = "https://services.marinetraffic.com/api/exportvessels/v:8/\(apiKey)/MINLAT:\(String(format: "%.4f", minLatitude ))/MAXLAT:\(String(format: "%.4f",maxLatitude))/MINLON:\(String(format: "%.4f",minLongitude))/MAXLON:\(String(format: "%.4f",maxLongitude))/timespan:60/protocol:jsono"
        
        AF.request(baseURL).responseDecodable(of: [BoatStruct].self){
            (response) in
            print("!!!!!!!!!!!")
            print(response)
            print("!!!!!!!!!!!")
            if response.error != nil {
            completion(false, response.error?.localizedDescription)
            }
            
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Boat")
            fetch.predicate = NSPredicate(value: true)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
            let _ = try? dataController.viewContext.execute(deleteRequest)
            if response.value == nil {
                completion(false,"Cannot parse API response! Did you use the correct API key?")
                return
            }
            
            for boat in response.value!{
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
            completion(true, nil)
        }
    }
}

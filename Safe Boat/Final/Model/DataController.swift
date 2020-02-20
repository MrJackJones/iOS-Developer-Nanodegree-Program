//
//  DataController.swift
//  Final
//
//  Created by Ivan on 18.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import Foundation
import CoreData
class DataController {
    let persistentContainer:NSPersistentContainer
    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    func load(completion:(()->Void)? = nil) {
        persistentContainer.loadPersistentStores {storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
}

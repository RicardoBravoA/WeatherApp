//
//  DataController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer: NSPersistentContainer
    static let shared = DataController(modelName: "Weather")
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureContext() {
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext()
            self.configureContext()
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
    
    func location() -> Location {
        return Location(context: viewContext)
    }
    
}

extension DataController {
    func autoSaveViewContext(interval:TimeInterval = 30) {
        
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }
        
        save()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}

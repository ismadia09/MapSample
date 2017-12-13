//
//  CoreDataHandler.swift
//  MapSample
//
//  Created by Isma Dia on 10/12/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler : NSObject {
    
   private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     return appDelegate.persistentContainer.viewContext

    }
    
    class func createStore(name: String, latitude: Double, longitude: Double, openingHours : String) -> Store{
        
        let context = getContext()
        let store = Store(context: context )
        store.name = name
        store.latitude = latitude
        store.longitude = longitude
        store.openingHours = openingHours
        
        try? context.save()
        
        do {
            try context.save()
            print("succes saving")
            return store
        }catch {
            print("Error creation store")
            return store
        }

    }
    
    class func fetchStore()-> [Store]? {
        let context = getContext()
        let request : NSFetchRequest<Store> = Store.fetchRequest()
        var stores : [Store]? = nil
        do{
            try stores = context.fetch(request)
            return stores
        }catch{
            print("Error fetch stores")
            return stores
        }
        
    }
    
    class func deleteAllStores() -> Bool {
        let context = getContext()
        let request : NSFetchRequest<Store> = Store.fetchRequest()
        do {
            let result = try context.fetch(request)
            for store in result {
                context.delete(store)
            }
             try? context.save()
            return true
            
        }catch{
            print ("erreur delete stores")
            return false
        }
    }
    
    class func deleteSpecificStore(id: Int){
        let context = getContext()
        let request : NSFetchRequest<Store> = Store.fetchRequest()
        do {
        var result = try context.fetch(request)
        let obj = result[id]
        context.delete(obj)
        try? context.save()
        }catch {
            print("error delete store " + String(id))
        }
    }
}

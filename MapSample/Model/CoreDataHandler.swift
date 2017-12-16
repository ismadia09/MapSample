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
    
    
    // On retourne un Store pour pouvoir l'ajouter dans le StoreProvider
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
    
    // On retourne un tableau de Store pour pouvoir l'ajouter dans le StoreProvider
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
    
    //Premier version de la methode qui fonctionne avec un table view
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
    
    class func updateSpecificStore(_ store: Store, name: String, latitude: Double, longitude: Double, openingHours : String){
        let context = getContext()
        let request : NSFetchRequest<Store> = Store.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@ AND longitude == %@ AND latitude == %@ AND openingHours == %@", store.name!, String(store.longitude), String(store.latitude), store.openingHours! )
        do {
            let result = try context.fetch(request)
            for store in result{
                store.name = name
                store.longitude = longitude
                store.latitude = latitude
                store.openingHours = openingHours
            }
            try? context.save()
        }catch {
            print("error update store ")
        }
    }
}

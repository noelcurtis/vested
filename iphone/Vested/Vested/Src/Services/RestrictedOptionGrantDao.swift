//
//  RestrictedOptionGrantDao.swift
//  Vested
//
//  Created by ncurtis on 1/17/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//\

import Foundation
import CoreData

class RestrictedOptionGrantDao {
    
    var managedObjectContext: NSManagedObjectContext

    let fetchAllRestrictedOptionGrantRequest: NSFetchRequest = {
        let f = NSFetchRequest(entityName: "RestrictedOptionGrantMO")
        f.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return f
    }()
    
    func fetchRestrictedOptionGrantRequest(id: String) -> NSFetchRequest {
        let f = NSFetchRequest(entityName: "RestrictedOptionGrantMO")
        f.predicate = NSPredicate(format: "uuid == %@", id)
        return f
    }
    
    init (managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func createStockPlan(stockPlan: StockPlan) {
        println("Creating stock plan \(stockPlan.description)")
        let s = NSEntityDescription.insertNewObjectForEntityForName("RestrictedOptionGrantMO", inManagedObjectContext: self.managedObjectContext) as RestrictedOptionGrantMO
        s.setupWithStockPlan(stockPlan)
        save()
    }
    
    func findAllRestrictedOptionGrants() -> [RestrictedOptionGrant] {
        println("Finding all restricted option grants")
        if let fetchResults = self.managedObjectContext.executeFetchRequest(fetchAllRestrictedOptionGrantRequest, error: nil) {
            let resultsList = fetchResults as [RestrictedOptionGrantMO]
            println("Found \(resultsList.count) restricted option grants")

            return resultsList.map {
                (result: RestrictedOptionGrantMO) -> RestrictedOptionGrant in
                return RestrictedOptionGrant(stockPlan: result)
            }
        } else {
            return []
        }
    }
    
    func updateStockPlan(stockPlan: StockPlan) {
        println("Updating stock plan \(stockPlan.description)")
        if let fetchResults = self.managedObjectContext.executeFetchRequest(fetchRestrictedOptionGrantRequest(stockPlan.uuid), error: nil) {
            let resultOption = (fetchResults as [RestrictedOptionGrantMO]).first

            if let result = resultOption {
                result.updateWithStockPlan(stockPlan)
                save()
            } else {
                NSLog("Could not find stock plan with id \(stockPlan.uuid), update failed")
            }
        }
    }
    
    func findRestrictedOptionGrant(uuid: String) -> RestrictedOptionGrant? {
        println("Finding option grant with uuid \(uuid)")
        return RestrictedOptionGrant()
    }
    
    func save() {
        var error: NSError? = nil
        if self.managedObjectContext.hasChanges && !self.managedObjectContext.save(&error) {
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } else {
            NSLog("Saved context to persistent store.")
        }
    }

}
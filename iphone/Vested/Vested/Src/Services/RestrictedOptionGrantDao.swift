//
//  RestrictedOptionGrantDao.swift
//  Vested
//
//  Created by ncurtis on 1/17/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation
import CoreData

class RestrictedOptionGrantDao {
    
    var managedObjectContext: NSManagedObjectContext
    
    init (managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func createStockPlan(stockPlan: StockPlan) {
        println("Creating stock plan")
        let s = NSEntityDescription.insertNewObjectForEntityForName("RestrictedOptionGrantMO", inManagedObjectContext: self.managedObjectContext) as RestrictedOptionGrantMO
        s.setupWithStockPlan(stockPlan)
        
        var error: NSError? = nil
        if self.managedObjectContext.hasChanges && !self.managedObjectContext.save(&error) {
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } else {
            NSLog("Saved context to persistent store.")
        }
    }
    
    func findAllRestrictedOptionGrants() -> [RestrictedOptionGrant] {
        println("Finding all option grants")
        let fetchRequest = NSFetchRequest(entityName: "RestrictedOptionGrantMO")
        if let fetchResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as? [RestrictedOptionGrantMO] {
            return fetchResults.map {
                (result: RestrictedOptionGrantMO) -> RestrictedOptionGrant in
                return RestrictedOptionGrant(stockPlan: result)
            }
        } else {
            return []
        }
    }
    
    func findRestrictedOptionGrant(uuid: String) -> RestrictedOptionGrant? {
        println("Finding option grant with uuid \(uuid)")
        return RestrictedOptionGrant()
    }

}
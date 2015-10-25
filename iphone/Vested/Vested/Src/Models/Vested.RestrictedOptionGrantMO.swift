//
//  RestrictedOptionGrantMO.swift
//  Vested
//
//  Created by ncurtis on 1/17/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation
import CoreData

class RestrictedOptionGrantMO: NSManagedObject {

    @NSManaged var cliff: NSNumber
    @NSManaged var endingAcceleration: NSNumber
    @NSManaged var shares: NSNumber
    @NSManaged var startDate: NSDate
    @NSManaged var startingAcceleration: NSNumber
    @NSManaged var uuid: String
    @NSManaged var vestingPeriod: NSNumber
    @NSManaged var name: String
    @NSManaged var price: NSNumber
    
    func setupWithStockPlan(stockPlan: StockPlan) {
        self.uuid = stockPlan.uuid
        self.startingAcceleration = stockPlan.startingAcceleration
        self.endingAcceleration = stockPlan.endingAcceleration
        self.cliff = stockPlan.cliff
        self.vestingPeriod = stockPlan.vestingPeriod
        self.shares = stockPlan.shares
        self.startDate = stockPlan.startDate
        self.name = stockPlan.name
        self.price = stockPlan.price
    }
    
    func updateWithStockPlan(stockPlan: StockPlan) {
        self.startingAcceleration = stockPlan.startingAcceleration
        self.endingAcceleration = stockPlan.endingAcceleration
        self.cliff = stockPlan.cliff
        self.vestingPeriod = stockPlan.vestingPeriod
        self.shares = stockPlan.shares
        self.startDate = stockPlan.startDate
        self.name = stockPlan.name
        self.price = stockPlan.price
    }
    
    override var description: String { return  "{\"name:\"\(name)\", \"uuid:\"\(uuid)\", \"startingAcceleration:\(startingAcceleration), \"endingAcceleration:\(endingAcceleration), \"cliff:\(cliff), \"vestingPeriod:\(vestingPeriod), \"shares:\(shares), \"startDate:\"\(startDate), \"price:\"\(price)\"}" }

}

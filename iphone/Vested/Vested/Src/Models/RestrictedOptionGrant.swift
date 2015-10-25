//
//  RestrictedOptionGrant.swift
//  Vested
//
//  Created by ncurtis on 1/6/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

class RestrictedOptionGrant : StockPlan {

    // plan parameters
    @objc var uuid: String
    @objc var name: String
    @objc var startingAcceleration: Double
    @objc var endingAcceleration: Double
    @objc var cliff: Int // in months
    @objc var vestingPeriod: Int // in months
    
    // individual parameters
    @objc var shares: Int
    @objc var startDate: NSDate
    @objc var price: Double
    
    @objc var description: String { return  "{\"name:\"\(name)\", \"uuid:\"\(uuid)\", \"startingAcceleration:\(startingAcceleration), \"endingAcceleration:\(endingAcceleration), \"cliff:\(cliff), \"vestingPeriod:\(vestingPeriod), \"shares:\(shares), \"startDate:\"\(startDate), \"price:\"\(price)\"}" }
    
    
    init() {
        self.uuid = NSUUID().UUIDString
        self.name = ""
        self.startingAcceleration = 0
        self.endingAcceleration = 0
        self.cliff = 0
        self.vestingPeriod = 0
        self.shares = 0
        self.startDate = NSDate()
        self.price = 0
    }
    
    init(stockPlan: RestrictedOptionGrantMO) {
        self.uuid = stockPlan.uuid
        self.startingAcceleration = stockPlan.startingAcceleration.doubleValue
        self.endingAcceleration = stockPlan.endingAcceleration.doubleValue
        self.cliff = stockPlan.cliff.integerValue
        self.vestingPeriod = stockPlan.vestingPeriod.integerValue
        self.shares = stockPlan.shares.integerValue
        self.startDate = stockPlan.startDate
        self.name = stockPlan.name
        self.price = stockPlan.price.doubleValue
    }
    
    func withDefaults() -> RestrictedOptionGrant {
        self.uuid = NSUUID().UUIDString
        self.startingAcceleration = 0
        self.endingAcceleration = 0
        self.cliff = 12
        self.vestingPeriod = 48
        self.shares = 5000
        self.startDate = NSDate()
        self.name = "My Stock Grant"
        self.price = 0.0
        
        return self
    }
    
    func withStartDateOneYearAgo() -> RestrictedOptionGrant {
        let oneYearAgo = NSDate().dateByAddingTimeInterval(-365 * 24 * 60 * 60)
        return self.withStartDate(oneYearAgo)
    }
    
    func withStartDate(startDate: NSDate) -> RestrictedOptionGrant {
        self.startDate = startDate
        return self
    }
    
    func withCliff(cliff: Int) -> RestrictedOptionGrant {
        self.cliff = cliff
        return self
    }
    
    func withVestingPeriod(vestingPeriod: Int) -> RestrictedOptionGrant {
        self.vestingPeriod = vestingPeriod
        return self
    }
    
    func withShares(shares: Int) -> RestrictedOptionGrant {
        self.shares = shares
        return self
    }
    
    func withStartingAcceleration(startingAcceleration: Double) -> RestrictedOptionGrant {
        self.startingAcceleration = startingAcceleration
        return self
    }
    
    func withEndingAcceleration(endingAcceleration: Double) -> RestrictedOptionGrant {
        self.endingAcceleration = endingAcceleration
        return self
    }
    
    func withName(name: String) -> RestrictedOptionGrant {
        self.name = name
        return self
    }
    
    func withCliff(cliff: Int, shares: Int, vestingPeriod: Int) -> RestrictedOptionGrant {
        self.cliff = cliff
        self.shares = shares
        self.vestingPeriod = vestingPeriod
        return self
    }
    
    func withAcceleration(startingAcceleration: Double, endingAcceleration: Double) -> RestrictedOptionGrant {
        self.startingAcceleration = startingAcceleration
        self.endingAcceleration = endingAcceleration
        return self
    }
    
    func withSharePrice(sharePrice: Double) -> RestrictedOptionGrant {
        self.price = sharePrice
        return self
    }
    
}
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
    var uuid: String
    var startingAcceleration: Double
    var endingAcceleration: Double
    var cliff: Int // in months
    var vestingPeriod: Int // in months
    
    // individual parameters
    var shares: Int
    var startDate: NSDate
    
    init() {
        self.uuid = NSUUID().UUIDString
        self.startingAcceleration = 0
        self.endingAcceleration = 0
        self.cliff = 0
        self.vestingPeriod = 0
        self.shares = 0
        self.startDate = NSDate()
    }
    
    init(stockPlan: RestrictedOptionGrantMO) {
        self.uuid = stockPlan.uuid
        self.startingAcceleration = stockPlan.startingAcceleration.doubleValue
        self.endingAcceleration = stockPlan.endingAcceleration.doubleValue
        self.cliff = stockPlan.cliff.integerValue
        self.vestingPeriod = stockPlan.vestingPeriod.integerValue
        self.shares = stockPlan.shares.integerValue
        self.startDate = stockPlan.startDate
    }
    
    func withDefaults() -> RestrictedOptionGrant {
        self.uuid = NSUUID().UUIDString
        self.startingAcceleration = 0
        self.endingAcceleration = 0
        self.cliff = 12
        self.vestingPeriod = 48
        self.shares = 5000
        self.startDate = NSDate()
        
        return self
    }
    
    func withStartDateOneYearAgo() -> RestrictedOptionGrant {
        var oneYearAgo = NSDate().dateByAddingTimeInterval(-365 * 24 * 60 * 60)
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
    
}
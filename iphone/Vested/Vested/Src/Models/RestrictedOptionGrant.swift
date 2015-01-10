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
    var uuid: NSUUID = NSUUID()
    var startingAcceleration: Double = 0
    var endingAcceleration: Double = 0
    var cliff: Int = 12 // in months
    var vestingPeriod: Int = 48 // in months
    
    // individual parameters
    var shares: Int = 5000
    var startDate: NSDate = NSDate()
    
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
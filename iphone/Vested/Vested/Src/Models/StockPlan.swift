//
//  StockPlan.swift
//  Vested
//
//  Created by ncurtis on 1/6/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

@objc protocol StockPlan {

    var uuid: String {get set}
    var name: String {get set}
    
    // plan parameters
    var startingAcceleration: Double {get set}
    var endingAcceleration: Double {get set}
    var cliff: Int {get set}
    var vestingPeriod: Int {get set}

    // individual parameters
    var shares: Int {get set}
    var startDate: NSDate {get set}
    
    /// A textual representation of `self`.
    var description: String { get }
    
    var price: Double {get set}
}

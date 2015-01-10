//
//  VestingCalculatorResult.swift
//  Vested
//
//  Created by ncurtis on 1/6/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

class VestingCalculatorResult {
    
    var startingShares: Int = 0
    var vestedShares: Int = 0
    var vestedSharesAtCliff: Int = 0
    var monthlyVestedShares: Double = 0
    var unvestedShares: Int = 0
    
    init(startingShares: Int,
        vestedShares: Int,
        vestedSharesAtCliff: Int,
        monthlyVestedShares: Double,
        unvestedShares: Int) {
            self.startingShares = startingShares
            self.vestedShares = vestedShares
            self.vestedSharesAtCliff = vestedSharesAtCliff
            self.monthlyVestedShares = monthlyVestedShares
            self.unvestedShares = unvestedShares
    }

}
//
//  RestrictedStockOptionGrantCalculator.swift
//  Vested
//
//  Created by ncurtis on 1/6/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

class RestrictedStockOptionGrantCalculator : VestingCalculator {
    
    func calculate(stockPlan: StockPlan) -> VestingCalculatorResult {
        
        let startingShares = Int(round(stockPlan.startingAcceleration / 100 * Double(stockPlan.shares)))
        
        let remainingUnvestedShares : Int = stockPlan.shares - startingShares
        
        let monthlyVestedShares = Double(remainingUnvestedShares)/Double(stockPlan.vestingPeriod)
        
        let monthsPassedSinceStart = NSCalendar.currentCalendar().components(
            NSCalendarUnit.Month,
                fromDate: stockPlan.startDate,
                toDate: NSDate(),
                options: []).month
        
        var vestedSharesAtCliff = 0
        if (monthsPassedSinceStart >= stockPlan.cliff) {
            vestedSharesAtCliff = Int(round(monthlyVestedShares * Double(stockPlan.cliff)))
        }
        
        var monthsBetweenCliffAndNow = 0
        if (monthsPassedSinceStart > stockPlan.cliff) {
            monthsBetweenCliffAndNow = monthsPassedSinceStart - stockPlan.cliff
        }
        
        let vestedSharesBetweenCliffAndNow = Int(round(monthlyVestedShares * Double(monthsBetweenCliffAndNow)))
        
        let endingShares = 0
        
        var vestedShares = startingShares + vestedSharesAtCliff + vestedSharesBetweenCliffAndNow + endingShares
        
        if (stockPlan.endingAcceleration > 0 && vestedShares < stockPlan.shares) {
            vestedShares += Int(round(stockPlan.endingAcceleration / 100 * Double(stockPlan.shares)))
        }
        
        vestedShares = min(vestedShares, stockPlan.shares)
        
        let unvestedShares = stockPlan.shares - vestedShares
        
        let vestedPercent = Double(vestedShares) / Double(stockPlan.shares) * 100
        
        let monthsLeftToVest = stockPlan.vestingPeriod - monthsPassedSinceStart
        
        return VestingCalculatorResult(
            startingShares: startingShares,
            vestedShares: vestedShares,
            vestedSharesAtCliff: vestedSharesAtCliff,
            monthlyVestedShares: monthlyVestedShares,
            unvestedShares: unvestedShares,
            vestedPercent: vestedPercent,
            monthsLeftToVest: monthsLeftToVest
        )
    }
    
}

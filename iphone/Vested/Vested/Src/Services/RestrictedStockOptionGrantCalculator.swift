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
        
        var startingShares = Int(round(stockPlan.startingAcceleration / 100 * Double(stockPlan.shares)))
        
        var remainingUnvestedShares : Int = stockPlan.shares - startingShares
        
        var monthlyVestedShares = Double(remainingUnvestedShares)/Double(stockPlan.vestingPeriod)
        
        var monthsPassedSinceStart = NSCalendar.currentCalendar().components(
            NSCalendarUnit.CalendarUnitMonth,
                fromDate: stockPlan.startDate,
                toDate: NSDate(),
                options: nil).month
        
        var vestedSharesAtCliff = 0
        if (monthsPassedSinceStart >= stockPlan.cliff) {
            vestedSharesAtCliff = Int(round(monthlyVestedShares * Double(stockPlan.cliff)))
        }
        
        var monthsBetweenCliffAndNow = 0
        if (monthsPassedSinceStart > stockPlan.cliff) {
            monthsBetweenCliffAndNow = monthsPassedSinceStart - stockPlan.cliff
        }
        
        var vestedSharesBetweenCliffAndNow = Int(round(monthlyVestedShares * Double(monthsBetweenCliffAndNow)))
        
        var endingShares = 0
        
        var vestedShares = startingShares + vestedSharesAtCliff + vestedSharesBetweenCliffAndNow + endingShares
        
        if (stockPlan.endingAcceleration > 0 && vestedShares < stockPlan.shares) {
            vestedShares += Int(round(stockPlan.endingAcceleration / 100 * Double(stockPlan.shares)))
        }
        
        vestedShares = min(vestedShares, stockPlan.shares)
        
        var unvestedShares = stockPlan.shares - vestedShares
        
        return VestingCalculatorResult(
            startingShares: startingShares,
            vestedShares: vestedShares,
            vestedSharesAtCliff: vestedSharesAtCliff,
            monthlyVestedShares: monthlyVestedShares,
            unvestedShares: unvestedShares
        )
    }
    
}

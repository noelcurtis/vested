//
//  VestingCalculator.swift
//  Vested
//
//  Created by ncurtis on 1/6/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

protocol VestingCalculator {
    
    func calculate(stockPLan: StockPlan) -> VestingCalculatorResult
    
}

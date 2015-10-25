//
//  RestrictedStockCalculatorTests.swift
//  Vested
//
//  Created by ncurtis on 1/10/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit
import XCTest

class RestrictedStockCalculatorTests : XCTestCase {
    
    var vestingCalculator: VestingCalculator?
    
    override func setUp() {
        super.setUp()
        vestingCalculator = RestrictedStockOptionGrantCalculator()
    }
    
    override func tearDown() {
        vestingCalculator = nil
        super.tearDown()
    }
    
    func test_CalculatorWithDefaultInputs_Success() {
        let defaultInputs = RestrictedOptionGrant().withDefaults().withStartDateOneYearAgo()
        var result: VestingCalculatorResult?
        self.measureBlock() {
            result = self.vestingCalculator?.calculate(defaultInputs)
        }
        XCTAssert(result?.vestedShares == 1250, "Vested shares should be 1250 but \(result?.vestedShares)")
        XCTAssert(result?.vestedSharesAtCliff == 1250, "Vested shares should be 1250 but \(result?.vestedShares)")
        XCTAssert(result?.startingShares == 0, "Starting shares should be 0 but \(result?.startingShares)")
        XCTAssert(result?.unvestedShares == 3750, "Unvested vested shares should be 5000 but \(result?.unvestedShares)")
    }
    
    func test_CalculatorWith_2YearCliff_Success() {
        let inputs = RestrictedOptionGrant().withDefaults().withStartDateOneYearAgo().withCliff(24)
        
        let result = vestingCalculator?.calculate(inputs)
        XCTAssert(result?.vestedShares == 0, "Vested shares should be 0 but \(result?.vestedShares)")
        XCTAssert(result?.startingShares == 0, "Starting shares should be 0 but \(result?.startingShares)")
        XCTAssert(result?.vestedSharesAtCliff == 0, "Vested shares at cliff should be 0 but \(result?.vestedSharesAtCliff)")
        XCTAssert(round(result!.monthlyVestedShares) == 104, "Monthly vested shares should be 104 but \(result?.monthlyVestedShares)")
        XCTAssert(result?.unvestedShares == 5000, "Unvested vested shares should be 5000 but \(result?.unvestedShares)")
    }
    
    func test_CalculatorWith_CliffAndShareVariations_Success() {
        let twoYearsAgo = NSDate().dateByAddingTimeInterval(-365 * 2 * 24 * 60 * 60)
        var inputs = RestrictedOptionGrant().withDefaults().withStartDate(twoYearsAgo).withCliff(24).withShares(100000)
        
        var result = vestingCalculator?.calculate(inputs)
        XCTAssert(result?.vestedShares == 50000, "Vested shares should be 50000 but \(result?.vestedShares)")
        XCTAssert(result?.unvestedShares == 50000, "Unvested shares should be 50000 but \(result?.unvestedShares)")
        
        inputs = inputs.withCliff(1, shares: 500000, vestingPeriod: 5 * 12)
        result = vestingCalculator?.calculate(inputs)
        XCTAssert(result?.vestedShares == 200000, "Vested shares should be 50000 but \(result?.vestedShares)")
        XCTAssert(result?.unvestedShares == 300000, "Unvested shares should be 50000 but \(result?.unvestedShares)")
    }
    
    func test_CalculatorWith_AccelerationVariations1_Success() {
        let twoYearsAgo = NSDate().dateByAddingTimeInterval(-365 * 2 * 24 * 60 * 60)
        let inputs = RestrictedOptionGrant().withDefaults().withStartDate(twoYearsAgo).withCliff(12).withStartingAcceleration(10)
        
        let result = vestingCalculator?.calculate(inputs)
        XCTAssert(result?.vestedShares == 2750, "Vested shares should be 2750 but \(result?.vestedShares)")
        XCTAssert(result?.unvestedShares == 2250, "Unvested shares should be 2250 but \(result?.unvestedShares)")
    }
    
    func test_CalculatorWith_AccelerationVariations2_Success() {
        let twoYearsAgo = NSDate().dateByAddingTimeInterval(-365 * 2 * 24 * 60 * 60)
        let inputs = RestrictedOptionGrant().withDefaults().withStartDate(twoYearsAgo).withCliff(12).withEndingAcceleration(10)
        
        let result = vestingCalculator?.calculate(inputs)
        XCTAssert(result?.vestedShares == 3000, "Vested shares should be 3000 but \(result?.vestedShares)")
        XCTAssert(result?.unvestedShares == 2000, "Unvested shares should be 2000 but \(result?.unvestedShares)")
    }
    
    func test_CalculatorWith_AccelerationVariation3_Success() {
        let twoYearsAgo = NSDate().dateByAddingTimeInterval(-365 * 2 * 24 * 60 * 60)
        let inputs = RestrictedOptionGrant().withDefaults().withStartDate(twoYearsAgo).withCliff(12).withAcceleration(10, endingAcceleration: 10)
        
        let result = vestingCalculator?.calculate(inputs)
        XCTAssert(result?.vestedShares == 3250, "Vested shares should be 3250 but \(result?.vestedShares)")
        XCTAssert(result?.unvestedShares == 1750, "Unvested shares should be 1750 but \(result?.unvestedShares)")
    }
    
    func test_CalculatorWith_AccelerationVariation4_Success() {
        let fourYearsAgo = NSDate().dateByAddingTimeInterval(-365 * 4 * 24 * 60 * 60)
        let inputs = RestrictedOptionGrant().withDefaults().withStartDate(fourYearsAgo).withCliff(12).withAcceleration(10, endingAcceleration: 10)
        
        let result = vestingCalculator?.calculate(inputs)
        XCTAssert(result?.vestedShares == 5000, "Vested shares should be 5000 but \(result?.vestedShares)")
        XCTAssert(result?.unvestedShares == 0, "Unvested shares should be 5000 but \(result?.unvestedShares)")
    }
    
    func test_CalculatorWith_AccelerationVariation5_Success() {
        let threeYearsAgo = NSDate().dateByAddingTimeInterval(-365 * 3 * 24 * 60 * 60)
        let inputs = RestrictedOptionGrant().withDefaults().withStartDate(threeYearsAgo).withCliff(12).withAcceleration(10, endingAcceleration: 20)
        
        let result = vestingCalculator?.calculate(inputs)
        XCTAssert(result?.vestedShares == 4781, "Vested shares should be 4781 but \(result?.vestedShares)")
        XCTAssert(result?.unvestedShares == 219, "Unvested shares should be 219 but \(result?.unvestedShares)")
    }
    
}

//
//  StockPlanTests.swift
//  Vested
//
//  Created by ncurtis on 1/6/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit
import XCTest

class StockPlanTests : XCTestCase {
 
    func test_RestrictedOptionGrant_Defaults_Success() {
        let stockGrant = RestrictedOptionGrant().withDefaults()
        
        XCTAssertEqual(stockGrant.shares, 5000, "Default shares count should be 4000")
        XCTAssertEqual(stockGrant.startingAcceleration, 0, "Acceleration should be 0")
        XCTAssertEqual(stockGrant.endingAcceleration, 0, "Ending Acceleration should be 0")
        XCTAssertEqual(stockGrant.vestingPeriod, 48, "Default vesting period should be 48")
        XCTAssertEqual(stockGrant.cliff, 12, "Default cliff should be 1")
        XCTAssertNotNil(stockGrant.startDate, "Start date can not be nil")
        XCTAssertNotNil(stockGrant.uuid, "UUID can not be nil")
        XCTAssertEqual(stockGrant.name, "My Stock Grant", "Name should be My Stock Grant")
    }
    
}
//
//  RestrictedGrantDaoTests.swift
//  Vested
//
//  Created by ncurtis on 1/17/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation
import XCTest

class RestrictedGrantDaoTests: XCTestCase {
    
    var restrictedGrantDao: RestrictedOptionGrantDao?
    
    override func setUp() {
        super.setUp()
        if let moc = PersistenceService.sharedInstance.inMemoryManagedObjectContext {
            restrictedGrantDao = RestrictedOptionGrantDao(managedObjectContext: moc)
        }
    }
    
    override func tearDown() {
        restrictedGrantDao = nil
        super.tearDown()
    }

    func test_CreateRestrictedOptionGrant_Success() {
//        let r = RestrictedOptionGrant().withDefaults()
//        restrictedGrantDao?.createStockPlan(r)
    }   
    
}

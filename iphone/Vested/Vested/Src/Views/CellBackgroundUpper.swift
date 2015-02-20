//
//  CellBackgroundUpper.swift
//  Vested
//
//  Created by ncurtis on 2/19/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class CellBackgroundUpper : UIImageView {
    
    var viewToDelegateHit : UIView?
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if let v = viewToDelegateHit {
            return v
        } else {
            return super.hitTest(point, withEvent: event)
        }
    }
    
}
//
//  NumberUtils.swift
//  Vested
//
//  Created by ncurtis on 1/19/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

let commatozeNumberFormatter: NSNumberFormatter = {
    let numberFormatter = NSNumberFormatter()
    numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
    return numberFormatter
    }()


class NumberUtils {
    
    class func commatoze(value: NSNumber) -> String {
        if let s = commatozeNumberFormatter.stringFromNumber(value) {
            return s
        } else {
            return ""
        }
    }
    
}
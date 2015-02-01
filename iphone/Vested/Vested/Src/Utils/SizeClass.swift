//
//  SizeTheme.swift
//  Vested
//
//  Created by ncurtis on 1/31/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

class SizeClass : Printable {
    
    let rowHeight: CGFloat = 110.0
    let rowHeightExpanded: CGFloat = 129.0
    let summaryButtomOffset: CGFloat = 40.0
    class var screenWidth: CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    
    init(rowHeight: CGFloat, rowHeightExpanded: CGFloat, summaryButtomOffset: CGFloat) {
        self.rowHeight = rowHeight
        self.rowHeightExpanded = rowHeightExpanded
        self.summaryButtomOffset = summaryButtomOffset
    }
    
    class func small() -> SizeClass {
        return SizeClass(rowHeight: 108, rowHeightExpanded: 138, summaryButtomOffset: 63)
    }
    
    class func medium() -> SizeClass {
        return SizeClass(rowHeight: 118, rowHeightExpanded: 168, summaryButtomOffset: 73)
    }
    
    class func large() -> SizeClass {
        return SizeClass(rowHeight: 128, rowHeightExpanded: 188, summaryButtomOffset: 73)
    }
    
    class func getClassForSize() -> SizeClass {
        switch(screenWidth) {
        case ColorsAndFonts.smallSize: return small()
        case ColorsAndFonts.mediumSize: return medium()
        case ColorsAndFonts.largeSize: return large()
        default: return medium()
        }
    }
    
    var description: String {
        return "rowHeight: \(rowHeight) rowHeightExpanded: \(rowHeightExpanded)"
    }
    
}
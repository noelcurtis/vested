//
//  ColorsAndFonts.swift
//  Vested
//
//  Created by ncurtis on 1/22/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

class ColorsAndFonts {
    
    class var screenWidth: CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    
    // MARK: - Colors
    class var backgroundBlack : UIColor {
        return UIColor(rgba: "#252A2D")
    }
    
    class var generalFontColor : UIColor {
        return UIColor.whiteColor()
    }
    
    class var vestedGreen : UIColor {
        return UIColor(rgba: "#5BE350")
    }
    
    class var unvestedRed : UIColor {
        return UIColor(rgba: "#FF6565")
    }
    
    // MARK: - Font Sizes
    class var summaryCellFontSize : CGFloat {
        switch(screenWidth) {
        case ColorsAndFonts.smallSize: return CGFloat(20)
        case ColorsAndFonts.mediumSize: return CGFloat(24)
        case ColorsAndFonts.largeSize: return CGFloat(26)
        default: return CGFloat(20)
        }

    }
    
    class var summaryCellSubFontSize : CGFloat {
        switch(screenWidth) {
        case ColorsAndFonts.smallSize: return CGFloat(14)
        case ColorsAndFonts.mediumSize: return CGFloat(16)
        case ColorsAndFonts.largeSize: return CGFloat(18)
        default: return CGFloat(16)
        }
    }
    
    class var summaryCellPercentLabelFontSize : CGFloat {
        switch(screenWidth) {
        case ColorsAndFonts.smallSize: return CGFloat(15)
        case ColorsAndFonts.mediumSize: return CGFloat(18)
        case ColorsAndFonts.largeSize: return CGFloat(22)
        default: return CGFloat(15)
        }
    }
    
    class var infoButtonLabelSize : CGFloat {
        switch(screenWidth) {
        case ColorsAndFonts.smallSize: return CGFloat(18)
        case ColorsAndFonts.mediumSize: return CGFloat(18)
        case ColorsAndFonts.largeSize: return CGFloat(20)
        default: return CGFloat(16)
        }
    }
    
    class var infoTextSize : CGFloat {
        switch(screenWidth) {
        case ColorsAndFonts.smallSize: return CGFloat(14)
        case ColorsAndFonts.mediumSize: return CGFloat(14)
        case ColorsAndFonts.largeSize: return CGFloat(16)
        default: return CGFloat(14)
        }
    }
    
    // MARK: - Fonts
    class var baseFont : String {
        return "AvenirNext-Medium"
    }
    class var slimFont : String {
        return "AvenirNext-Regular"
    }
    
    // MARK: - Sizes
    class var smallSize : CGFloat {
        return CGFloat(320.0)
    }
    
    class var mediumSize : CGFloat {
        return CGFloat(375.0)
    }
    
    class var largeSize : CGFloat {
        return CGFloat(414.0)
    }
    
}
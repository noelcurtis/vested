//
//  InfoViewV2.swift
//  Vested
//
//  Created by ncurtis on 2/2/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class InfoViewV2 : UIView {
    
    @IBOutlet weak var monthsToVestLabel: UILabel!
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var monthsToViestTitleLabel: UILabel!
    @IBOutlet weak var cliffBreachedTitleLabel: UILabel!
    @IBOutlet weak var cliffIndicator: UIImageView!
    @IBOutlet weak var separatorLine: UIView!
    
    func setup(monthsLeftToVest: Int, planName: String, cliffBreached: Bool) {
        planNameLabel.text = planName
        monthsToVestLabel.text = "\(monthsLeftToVest)"
    }
    
    func hideInfo(hidden: Bool) {
        monthsToViestTitleLabel.hidden = hidden
        cliffBreachedTitleLabel.hidden = hidden
        cliffIndicator.hidden = hidden
        monthsToVestLabel.hidden = hidden
        separatorLine.hidden = hidden
    }
    
}

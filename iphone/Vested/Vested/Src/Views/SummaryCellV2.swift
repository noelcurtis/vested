//
//  SummaryCellV2.swift
//  Vested
//
//  Created by ncurtis on 1/22/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

class SummaryCellV2 : UITableViewCell {
    
    let cellBackgroundUpper = UIImageView(image: UIImage(named: "summary_background_upper"))
    let cellBackgroundLower = UIImageView(image: UIImage(named: "summary_background_lower"))
    let leftWrapperView = UIView()
    let middleWrapperView = UIView()
    let rightWrapperView = UIView()
    let vestedLabel = UILabel()
    let unvestedLabel = UILabel()
    let vestedAmountLabel = UILabel()
    let unvestedAmountLabel = UILabel()
    let radialGraphView = MDRadialProgressView()
    let planNameLabel = UILabel()
    let infoImage = UIImageView(image: UIImage(named: "info_image"))
    let infoButton = UIButton()
    
    class var REUSE_IDENTIFIER : String {
        return "summary_cell_v2"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        cellBackgroundLower.setTranslatesAutoresizingMaskIntoConstraints(false)
        cellBackgroundUpper.setTranslatesAutoresizingMaskIntoConstraints(false)
        leftWrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        middleWrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        rightWrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        vestedLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        unvestedLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        vestedAmountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        unvestedAmountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        radialGraphView.setTranslatesAutoresizingMaskIntoConstraints(false)
        planNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        infoImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        infoButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        infoButton.enabled = true
        infoButton.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        infoButton.userInteractionEnabled = true
        
        cellBackgroundUpper.userInteractionEnabled = true

        cellBackgroundLower.userInteractionEnabled = true
        
        vestedLabel.font = UIFont(name: ColorsAndFonts.baseFont, size: ColorsAndFonts.summaryCellSubFontSize)
        vestedLabel.text = "Vested"
        vestedLabel.tintColor = ColorsAndFonts.generalFontColor
        vestedLabel.textColor = ColorsAndFonts.generalFontColor
        vestedLabel.textAlignment = NSTextAlignment.Right
        
        unvestedLabel.font = UIFont(name: ColorsAndFonts.baseFont, size: ColorsAndFonts.summaryCellSubFontSize)
        unvestedLabel.text = "Unvested"
        unvestedLabel.tintColor = ColorsAndFonts.generalFontColor
        unvestedLabel.textColor = ColorsAndFonts.generalFontColor
        unvestedLabel.textAlignment  = NSTextAlignment.Left
        
        vestedAmountLabel.font = UIFont(name: ColorsAndFonts.baseFont, size: ColorsAndFonts.summaryCellFontSize)
        vestedAmountLabel.text = ""
        vestedAmountLabel.tintColor = ColorsAndFonts.vestedGreen
        vestedAmountLabel.textColor = ColorsAndFonts.vestedGreen
        vestedAmountLabel.textAlignment  = NSTextAlignment.Right
        
        unvestedAmountLabel.font = UIFont(name: ColorsAndFonts.baseFont, size: ColorsAndFonts.summaryCellFontSize)
        unvestedAmountLabel.text = ""
        unvestedAmountLabel.tintColor = ColorsAndFonts.unvestedRed
        unvestedAmountLabel.textColor = ColorsAndFonts.unvestedRed
        unvestedAmountLabel.textAlignment  = NSTextAlignment.Left
        
        planNameLabel.font = UIFont(name: ColorsAndFonts.baseFont, size: ColorsAndFonts.summaryCellSubFontSize)
        planNameLabel.text = ""
        planNameLabel.tintColor = ColorsAndFonts.generalFontColor
        planNameLabel.textColor = ColorsAndFonts.generalFontColor
        planNameLabel.textAlignment  = NSTextAlignment.Right
        
        radialGraphView.progressCounter = 1
        radialGraphView.progressTotal = 100
        radialGraphView.theme.sliceDividerHidden = true
        radialGraphView.theme.completedColor = ColorsAndFonts.vestedGreen
        radialGraphView.theme.incompletedColor = ColorsAndFonts.unvestedRed
        radialGraphView.label.hidden = true
        radialGraphView.theme.thickness = 6
        radialGraphView.clockwise = false

        self.addSubview(cellBackgroundLower)
        self.addSubview(cellBackgroundUpper)
        leftWrapperView.addSubview(vestedLabel)
        leftWrapperView.addSubview(vestedAmountLabel)
        rightWrapperView.addSubview(unvestedLabel)
        rightWrapperView.addSubview(unvestedAmountLabel)
        middleWrapperView.addSubview(radialGraphView)
        self.addSubview(leftWrapperView)
        self.addSubview(middleWrapperView)
        self.addSubview(rightWrapperView)
        infoButton.addSubview(planNameLabel)
        infoButton.addSubview(infoImage)
        cellBackgroundLower.addSubview(infoButton)
        
        let viewsDictionary = [
            "summary_background_upper": cellBackgroundUpper,
            "summary_background_lower": cellBackgroundLower,
            "left_wrapper": leftWrapperView,
            "right_wrapper": rightWrapperView,
            "middle_wrapper": middleWrapperView,
            "vested_label": vestedLabel,
            "vested_amount_label": vestedAmountLabel,
            "unvested_label": unvestedLabel,
            "unvested_amount_label": unvestedAmountLabel,
            "radial_graph_view": radialGraphView,
            "plan_name_label": planNameLabel,
            "info_image": infoImage,
            "info_button": infoButton
        ]
        
        let hPlacement1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[summary_background_upper]-2-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement2 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-4-[summary_background_lower]-4-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement3 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[left_wrapper(==right_wrapper)]-[middle_wrapper(==66)]-[right_wrapper(==left_wrapper)]-5-|",
            options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement4 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vested_label]-2-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement5 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vested_amount_label]-2-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement6 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[unvested_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement7 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[unvested_amount_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement8 = NSLayoutConstraint(item: radialGraphView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: middleWrapperView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let hPlacement9 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[radial_graph_view]", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement10 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[info_button]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement11 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[plan_name_label]", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement12 = NSLayoutConstraint.constraintsWithVisualFormat("H:[info_image]-10-|", options: nil, metrics: nil, views: viewsDictionary)

        let vPlacement1 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[summary_background_upper]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[summary_background_lower]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement3 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[left_wrapper]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement4 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[right_wrapper]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement5 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[middle_wrapper]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement6 = NSLayoutConstraint(item: leftWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Height, multiplier: 0.93, constant: 0.0)
        let vPlacement7 = NSLayoutConstraint(item: rightWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Height, multiplier: 0.93, constant: 0.0)
        let vPlacement8 = NSLayoutConstraint(item: middleWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Height, multiplier: 0.93, constant: 0.0)
        let vPlacement9 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[vested_label]-(-4)-[vested_amount_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement10 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[unvested_label]-(-4)-[unvested_amount_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement11 = NSLayoutConstraint(item: radialGraphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: middleWrapperView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let vPlacement12 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[radial_graph_view]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement13 = NSLayoutConstraint.constraintsWithVisualFormat("V:[info_button]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement14 = NSLayoutConstraint.constraintsWithVisualFormat("V:[plan_name_label]-2-|", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement15 = NSLayoutConstraint.constraintsWithVisualFormat("V:[info_image]-5-|", options: nil, metrics: nil, views: viewsDictionary)
        
        self.addConstraints(hPlacement1)
        self.addConstraints(hPlacement2)
        self.addConstraints(hPlacement3)
        self.addConstraints(hPlacement4)
        self.addConstraints(hPlacement5)
        self.addConstraints(hPlacement6)
        self.addConstraints(hPlacement7)
        self.addConstraint(hPlacement8)
        self.addConstraints(hPlacement9)
        self.addConstraints(hPlacement10)
        self.addConstraints(hPlacement11)
        self.addConstraints(hPlacement12)
        
        self.addConstraints(vPlacement1)
        self.addConstraints(vPlacement2)
        self.addConstraints(vPlacement3)
        self.addConstraints(vPlacement4)
        self.addConstraints(vPlacement5)
        self.addConstraint(vPlacement6)
        self.addConstraint(vPlacement7)
        self.addConstraint(vPlacement8)
        self.addConstraints(vPlacement9)
        self.addConstraints(vPlacement10)
        self.addConstraint(vPlacement11)
        self.addConstraints(vPlacement12)
        self.addConstraints(vPlacement13)
        self.addConstraints(vPlacement14)
        self.addConstraints(vPlacement15)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize(stockPlan: StockPlan, vestingResult: VestingCalculatorResult) {
        vestedAmountLabel.text = NumberUtils.commatoze(vestingResult.vestedShares)
        unvestedAmountLabel.text = NumberUtils.commatoze(vestingResult.unvestedShares)
        radialGraphView.progressCounter =  max(UInt(round(vestingResult.vestedPercent)), 1)
        planNameLabel.text = stockPlan.name
    }
    
    func buttonClick(sender: UIButton!) {
        NSLog("I was clicked!")
    }
    
}
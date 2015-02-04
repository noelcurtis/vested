//
//  SummaryCellV2.swift
//  Vested
//
//  Created by ncurtis on 1/22/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation

protocol CellDetailButtonDelegate {
    
    func detailButtonPressed(cell: UITableViewCell)
    
}

class SummaryCellV2 : UITableViewCell {
    
    let cellBackgroundLower : InfoViewV2!
    let cellBackgroundUpper = UIImageView(image: UIImage(named: "summary_background_upper"))
    let leftWrapperView = UIView()
    let middleWrapperView = UIView()
    let rightWrapperView = UIView()
    let vestedLabel = UILabel()
    let unvestedLabel = UILabel()
    let vestedAmountLabel = UILabel()
    let unvestedAmountLabel = UILabel()
    let radialGraphView = MDRadialProgressView()
    let percentLabel = UILabel()
    let detailButton = UIButton()
    
    var cellDetailButtonPressedDelegate : CellDetailButtonDelegate?
    var indexPath: NSIndexPath?
    
    let duration = 200.0
    let delay = 0.0
    let options = UIViewKeyframeAnimationOptions.LayoutSubviews
    
    var vPlacementDynamic: NSLayoutConstraint?
    
    class var REUSE_IDENTIFIER : String {
        return "summary_cell_v2"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        let bundle = NSBundle(forClass: self.dynamicType)
        cellBackgroundLower = bundle.loadNibNamed("InfoViewV2", owner: nil, options: nil)[0] as? InfoViewV2
        
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        cellBackgroundUpper.setTranslatesAutoresizingMaskIntoConstraints(false)
        leftWrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        middleWrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        rightWrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        vestedLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        unvestedLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        vestedAmountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        unvestedAmountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        radialGraphView.setTranslatesAutoresizingMaskIntoConstraints(false)
        percentLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cellBackgroundLower.setTranslatesAutoresizingMaskIntoConstraints(false)
        detailButton.setTranslatesAutoresizingMaskIntoConstraints(false)

//        infoButton.backgroundColor = UIColor.blackColor()
//        leftWrapperView.backgroundColor = UIColor.yellowColor()
//        rightWrapperView.backgroundColor = UIColor.greenColor()
//        middleWrapperView.backgroundColor = UIColor.grayColor()
//        detailButton.backgroundColor = UIColor.yellowColor()
        
        cellBackgroundUpper.userInteractionEnabled = true
        contentView.userInteractionEnabled = true
        detailButton.userInteractionEnabled = true
        
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
        
        percentLabel.font = UIFont(name: ColorsAndFonts.slimFont, size: ColorsAndFonts.summaryCellPercentLabelFontSize)
        percentLabel.text = "100%"
        percentLabel.tintColor = ColorsAndFonts.generalFontColor
        percentLabel.textColor = ColorsAndFonts.generalFontColor
        percentLabel.textAlignment  = NSTextAlignment.Center
        
        radialGraphView.progressCounter = 1
        radialGraphView.progressTotal = 100
        radialGraphView.theme.sliceDividerHidden = true
        radialGraphView.theme.completedColor = ColorsAndFonts.vestedGreen
        radialGraphView.theme.incompletedColor = ColorsAndFonts.unvestedRed
        radialGraphView.label.hidden = true
        radialGraphView.theme.thickness = 8
        radialGraphView.clockwise = false

        leftWrapperView.addSubview(vestedLabel)
        leftWrapperView.addSubview(vestedAmountLabel)
        rightWrapperView.addSubview(unvestedLabel)
        rightWrapperView.addSubview(unvestedAmountLabel)
        middleWrapperView.addSubview(radialGraphView)
        middleWrapperView.addSubview(percentLabel)
        contentView.addSubview(cellBackgroundLower)
        contentView.addSubview(cellBackgroundUpper)
        contentView.addSubview(leftWrapperView)
        contentView.addSubview(middleWrapperView)
        contentView.addSubview(rightWrapperView)
        contentView.addSubview(detailButton)
        
        let viewsDictionary = [
            "summary_background_lower": cellBackgroundLower,
            "summary_background_upper": cellBackgroundUpper,
            "left_wrapper": leftWrapperView,
            "right_wrapper": rightWrapperView,
            "middle_wrapper": middleWrapperView,
            "vested_label": vestedLabel,
            "vested_amount_label": vestedAmountLabel,
            "unvested_label": unvestedLabel,
            "unvested_amount_label": unvestedAmountLabel,
            "radial_graph_view": radialGraphView,
            "percent_label": percentLabel,
            "detail_button": detailButton
        ]
        
        let hPlacement1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[summary_background_upper]-2-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement2 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[summary_background_lower]-8-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement3 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[left_wrapper(==right_wrapper)]-[middle_wrapper]-[right_wrapper(==left_wrapper)]-5-|",
            options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement4 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vested_label]-2-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement5 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vested_amount_label]-2-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement6 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[unvested_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement7 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[unvested_amount_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement8 = NSLayoutConstraint(item: radialGraphView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: middleWrapperView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let hPlacement9 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[radial_graph_view]", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement13 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[percent_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hPlacement14 = NSLayoutConstraint(item: middleWrapperView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 0.20, constant: 0.0)
        let hPlacement15 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[detail_button]-0-|", options: nil, metrics: nil, views: viewsDictionary)

        let vPlacement1 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[summary_background_upper]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-38-[summary_background_lower]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement3 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[left_wrapper]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement4 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[right_wrapper]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement5 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[middle_wrapper]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement6 = NSLayoutConstraint(item: leftWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Height, multiplier: 0.93, constant: 0.0)
        let vPlacement7 = NSLayoutConstraint(item: rightWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Height, multiplier: 0.93, constant: 0.0)
        let vPlacement8 = NSLayoutConstraint(item: middleWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Height, multiplier: 0.93, constant: 0.0)
        let vPlacement9 = NSLayoutConstraint.constraintsWithVisualFormat("V:[vested_label]-(-2)-[vested_amount_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement10 = NSLayoutConstraint.constraintsWithVisualFormat("V:[unvested_label]-(-2)-[unvested_amount_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement11 = NSLayoutConstraint(item: radialGraphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: middleWrapperView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let vPlacement12 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[radial_graph_view]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement16 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[percent_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement17 = NSLayoutConstraint(item: middleWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: middleWrapperView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0)
        let vPlacement19 = NSLayoutConstraint(item: vestedLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Top, multiplier: 2.5, constant: 0.0)
        let vPlacement20 = NSLayoutConstraint(item: unvestedLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Top, multiplier: 2.5, constant: 0.0)
        let vPlacement21 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[detail_button]", options: nil, metrics: nil, views: viewsDictionary)
        let vPlacement22 = NSLayoutConstraint(item: detailButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Height, multiplier: 0.80, constant: 0.0)
        
        vPlacementDynamic = NSLayoutConstraint(item: cellBackgroundLower, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellBackgroundUpper, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)

        contentView.addConstraints(hPlacement1)
        contentView.addConstraints(hPlacement2)
        contentView.addConstraints(hPlacement3)
        contentView.addConstraints(hPlacement4)
        contentView.addConstraints(hPlacement5)
        contentView.addConstraints(hPlacement6)
        contentView.addConstraints(hPlacement7)
        contentView.addConstraint(hPlacement8)
        contentView.addConstraints(hPlacement9)
        contentView.addConstraints(hPlacement13)
        contentView.addConstraint(hPlacement14)
        contentView.addConstraints(hPlacement15)
        
        contentView.addConstraints(vPlacement1)
        contentView.addConstraints(vPlacement2)
        contentView.addConstraints(vPlacement3)
        contentView.addConstraints(vPlacement4)
        contentView.addConstraints(vPlacement5)
        contentView.addConstraint(vPlacement6)
        contentView.addConstraint(vPlacement7)
        contentView.addConstraint(vPlacement8)
        contentView.addConstraints(vPlacement9)
        contentView.addConstraints(vPlacement10)
        contentView.addConstraint(vPlacement11)
        contentView.addConstraints(vPlacement12)
        contentView.addConstraints(vPlacement16)
        contentView.addConstraint(vPlacement17)
        contentView.addConstraint(vPlacement19)
        contentView.addConstraint(vPlacement20)
        contentView.addConstraint(vPlacementDynamic!)
        contentView.addConstraints(vPlacement21)
        contentView.addConstraint(vPlacement22)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize(stockPlan: StockPlan, vestingResult: VestingCalculatorResult, indexPath: NSIndexPath) {
        vestedAmountLabel.text = NumberUtils.commatoze(vestingResult.vestedShares)
        unvestedAmountLabel.text = NumberUtils.commatoze(vestingResult.unvestedShares)
        radialGraphView.progressCounter =  max(UInt(round(vestingResult.vestedPercent)), 1)
        percentLabel.text = "\(round(vestingResult.vestedPercent * 10) / 10)%"
        
        cellBackgroundLower.hideInfo(false)
        cellBackgroundLower.backgroundButton.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        cellBackgroundLower.monthsToVestLabel.text = "\(vestingResult.monthsLeftToVest)"
        cellBackgroundLower.cliffIndicator.image = vestingResult.vestedSharesAtCliff > 0 ? UIImage(named: "info_check") : UIImage(named: "info_cross");
        
        detailButton.addTarget(self, action: "detailButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.indexPath = indexPath
    }
    
    func buttonClick(sender: UIButton!) {
        NSLog("I was clicked!")
        if let delegate = cellDetailButtonPressedDelegate {
            delegate.detailButtonPressed(self)
        }
    }
    
    func  detailButtonClick(sender: UIButton!) {
        println("detail button clicked")
    }

    func expandDetailView() {
        NSLog("Expanding view")
        vPlacementDynamic?.constant = 65
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            self.contentView.layoutIfNeeded()
            }, completion: {(finished) -> Void in
        })
    }
    
    func contractDetailView() {
        NSLog("Contract view")
        vPlacementDynamic?.constant = 0.0
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            self.contentView.layoutIfNeeded()
            }, completion: {(finished) -> Void in
        
        })
    }
    
}
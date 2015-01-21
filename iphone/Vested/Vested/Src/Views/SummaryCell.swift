//
//  SummaryCell.swift
//  Vested
//
//  Created by ncurtis on 1/19/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation
import UIKit

class SummaryCell: UITableViewCell {
    
    let planNameBackground = UIImageView(image: UIImage(named: "summary_top_rectangle"))
    let planSummaryBackground = UIImageView(image: UIImage(named: "summary_bottom_rectangle"))
    let planNameLabel = UILabel()
    let vestedLabel = UILabel()
    let unvestedLabel = UILabel()
    let vestedAmountLabel = UILabel()
    let unvestedAmountLabel = UILabel()
    let leftWrapperView = UIView()
    let rightWrapperView = UIView()
    let radialGraphView = MDRadialProgressView()
    
    class var REUSE_IDENTIFIER : String {
        return "summary_cell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None

        planNameBackground.setTranslatesAutoresizingMaskIntoConstraints(false)
        planSummaryBackground.setTranslatesAutoresizingMaskIntoConstraints(false)
        planNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        vestedLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        unvestedLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        vestedAmountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        unvestedAmountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        leftWrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        rightWrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        radialGraphView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        planNameLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        planNameLabel.text = "Label"
        planNameLabel.tintColor = UIColor.whiteColor()
        planNameLabel.textColor = UIColor.whiteColor()
        
        vestedLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        vestedLabel.text = "Vested"
        vestedLabel.tintColor = UIColor.whiteColor()
        vestedLabel.textColor = UIColor.whiteColor()
        vestedLabel.textAlignment = NSTextAlignment.Center
        
        unvestedLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        unvestedLabel.text = "Unvested"
        unvestedLabel.tintColor = UIColor.whiteColor()
        unvestedLabel.textColor = UIColor.whiteColor()
        unvestedLabel.textAlignment  = NSTextAlignment.Center
        
        vestedAmountLabel.font = UIFont(name: "AvenirNext-Medium", size: 28)
        vestedAmountLabel.text = ""
        vestedAmountLabel.tintColor = UIColor(rgba: "#5BE350")
        vestedAmountLabel.textColor = UIColor(rgba: "#5BE350")
        vestedAmountLabel.textAlignment  = NSTextAlignment.Center
        
        unvestedAmountLabel.font = UIFont(name: "AvenirNext-Medium", size: 28)
        unvestedAmountLabel.text = ""
        unvestedAmountLabel.tintColor = UIColor(rgba: "#FF6565")
        unvestedAmountLabel.textColor = UIColor(rgba: "#FF6565")
        unvestedAmountLabel.textAlignment  = NSTextAlignment.Center
        
        radialGraphView.progressCounter = 4000
        radialGraphView.progressTotal = 5000
        radialGraphView.theme.sliceDividerHidden = true
        
        self.addSubview(planNameBackground)
        self.addSubview(planSummaryBackground)
        self.addSubview(planNameLabel)
        leftWrapperView.addSubview(vestedLabel)
        leftWrapperView.addSubview(vestedAmountLabel)
        rightWrapperView.addSubview(unvestedLabel)
        rightWrapperView.addSubview(unvestedAmountLabel)
        self.addSubview(leftWrapperView)
        self.addSubview(rightWrapperView)
        self.addSubview(radialGraphView)
        
        let viewsDictionary = ["plan_name_background": planNameBackground, "plan_summary_background": planSummaryBackground, "plan_name_label": planNameLabel, "vested_label": vestedLabel, "unvested_label": unvestedLabel, "unvested_amount_label": unvestedAmountLabel, "vested_amount_label": vestedAmountLabel, "left_wrapper": leftWrapperView, "right_wrapper": rightWrapperView, "radial_graph_view": radialGraphView]
        
        let hPlacement1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[plan_name_background]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hplacement2 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[plan_summary_background]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hplacement3 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[plan_name_label]-24-|", options: nil, metrics: nil, views: viewsDictionary)
        let hplacement4 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vested_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hplacement5 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vested_amount_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hplacement6 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[unvested_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hplacement7 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[unvested_amount_label]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hplacement8 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[left_wrapper(==right_wrapper)]-[radial_graph_view]-[right_wrapper(==left_wrapper)]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let hplacement9 = NSLayoutConstraint(item: radialGraphView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: leftWrapperView, attribute: NSLayoutAttribute.Width, multiplier: 0.50, constant: 0.0)

        let vplacement1 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[plan_name_background]-0-[plan_summary_background]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[vested_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement3 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[unvested_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement4 = NSLayoutConstraint.constraintsWithVisualFormat("V:[vested_label]-(-2)-[vested_amount_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement5 = NSLayoutConstraint.constraintsWithVisualFormat("V:[unvested_label]-(-2)-[unvested_amount_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement6 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-32-[left_wrapper]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement7 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-32-[right_wrapper]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement8 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[plan_name_label]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement9 = NSLayoutConstraint(item: leftWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: planSummaryBackground, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let vplacement10 = NSLayoutConstraint(item: rightWrapperView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: planSummaryBackground, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let vplacement11 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-32-[radial_graph_view]", options: nil, metrics: nil, views: viewsDictionary)
        let vplacement12 = NSLayoutConstraint(item: radialGraphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: planSummaryBackground, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
            
        self.addConstraints(hPlacement1)
        self.addConstraints(hplacement2)
        self.addConstraints(hplacement3)
        self.addConstraints(hplacement4)
        self.addConstraints(hplacement5)
        self.addConstraints(hplacement6)
        self.addConstraints(hplacement7)
        self.addConstraints(hplacement8)
        self.addConstraint(hplacement9)
        
        self.addConstraints(vplacement1)
        self.addConstraints(vplacement2)
        self.addConstraints(vplacement3)
        self.addConstraints(vplacement4)
        self.addConstraints(vplacement5)
        self.addConstraints(vplacement6)
        self.addConstraints(vplacement7)
        self.addConstraints(vplacement8)
        self.addConstraint(vplacement9)
        self.addConstraint(vplacement10)
        self.addConstraints(vplacement11)
        self.addConstraint(vplacement12)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize(stockPlan: StockPlan, vestingResult: VestingCalculatorResult) {
        planNameLabel.text = stockPlan.name
        vestedAmountLabel.text = NumberUtils.commatoze(vestingResult.vestedShares)
        unvestedAmountLabel.text = NumberUtils.commatoze(vestingResult.unvestedShares)
    }
}








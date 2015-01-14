//
//  InputCell.swift
//  Vested
//
//  Created by ncurtis on 1/11/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class PlanNameInputCell : UITableViewCell {

    let titleInputField = UITextField()
    let underLineImageView = UIImageView(image: UIImage(named: "title_line"))

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        underLineImageView.setTranslatesAutoresizingMaskIntoConstraints(false)

        titleInputField.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleInputField.font = UIFont(name: "AvenirNext-Medium", size: 26)
        titleInputField.text = "Plan Name"
        titleInputField.tintColor = UIColor.whiteColor()
        titleInputField.textColor = UIColor.whiteColor()

        self.addSubview(titleInputField)
        self.addSubview(underLineImageView)
        
        let viewsDictionary : [NSObject: AnyObject] = ["input_field": titleInputField, "underline_image": underLineImageView]
        let labelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[input_field]-0-[underline_image]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let labelHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[input_field]-10-|", options: nil, metrics: nil, views: viewsDictionary)

        self.addConstraints(labelVerticalConstraints)
        self.addConstraints(labelHorizontalConstraints)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ValueInputCell.swift
//  Vested
//
//  Created by ncurtis on 1/12/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class ValueInputCell : UITableViewCell {
    
    let labelField = UILabel()
    let underlineImage = UIImageView(image: UIImage(named: "input_cell_line"))
    let inputField = UITextField()

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None

        labelField.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelField.font = UIFont(name: "AvenirNext-Medium", size: 20)
        labelField.text = "Label"
        labelField.tintColor = UIColor.whiteColor()
        labelField.textColor = UIColor.whiteColor()
        
        underlineImage.setTranslatesAutoresizingMaskIntoConstraints(false)

        inputField.setTranslatesAutoresizingMaskIntoConstraints(false)
        inputField.font = UIFont(name: "AvenirNext-Medium", size: 26)
        inputField.text = "10,000"
        inputField.tintColor = UIColor.whiteColor()
        inputField.textColor = UIColor.whiteColor()
        inputField.textAlignment = NSTextAlignment.Right
        
        self.addSubview(labelField)
        self.addSubview(inputField)
        self.addSubview(underlineImage)
    
        let viewsDictionary : [NSObject: AnyObject] = ["label_field": labelField, "underline_image": underlineImage, "input_field": inputField]
        let labelInputHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label_field]-[input_field(==155)]-10-|", options: nil, metrics: nil, views: viewsDictionary)
        let labelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[label_field]", options: nil, metrics: nil, views: viewsDictionary)
        let underlineImageHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[underline_image]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let underlineImageVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[input_field]-0-[underline_image]", options: nil, metrics: nil, views: viewsDictionary)
        
        self.addConstraints(labelInputHorizontalConstraints)
        self.addConstraints(labelVerticalConstraints)
        self.addConstraints(underlineImageHorizontalConstraints)
        self.addConstraints(underlineImageVerticalConstraints)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


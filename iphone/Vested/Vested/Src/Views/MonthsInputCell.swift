//
//  MonthsInputCell.swift
//  Vested
//
//  Created by ncurtis on 1/13/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class MonthsInputCell : UITableViewCell, UITextFieldDelegate, FormCell {

    let labelField = UILabel()
    let underlineImage = UIImageView(image: UIImage(named: "input_cell_line"))
    let inputField = UITextField()
    let monthsLabel = UILabel()
    var inputCellFormDelegate : InputCellFormDelegate?
    let swipeLeftToClearGestureRecognizer: UISwipeGestureRecognizer!
    
    class var REUSE_IDENTIFIER : String {
        return "months_input_cell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        swipeLeftToClearGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "clearInput")
        swipeLeftToClearGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeLeftToClearGestureRecognizer)
        
        monthsLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        monthsLabel.text = "months"
        monthsLabel.tintColor = UIColor.whiteColor()
        monthsLabel.textColor = UIColor.whiteColor()
        
        monthsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        labelField.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelField.font = UIFont(name: "AvenirNext-Medium", size: 16)
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
        inputField.keyboardType = UIKeyboardType.DecimalPad
        inputField.delegate = self
        
        self.addSubview(labelField)
        self.addSubview(inputField)
        self.addSubview(underlineImage)
        self.addSubview(monthsLabel)
        
        let viewsDictionary : [NSObject: AnyObject] = ["label_field": labelField, "underline_image": underlineImage, "input_field": inputField, "months_label": monthsLabel]
        let labelInputHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label_field]-[input_field(==50)]-2-[months_label]-10-|", options: nil, metrics: nil, views: viewsDictionary)
        let labelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[label_field]", options: nil, metrics: nil, views: viewsDictionary)
        let monthsLabelVertialConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[months_label]", options: nil, metrics: nil, views: viewsDictionary)
        let underlineImageHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[underline_image(==140)]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let underlineImageVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[input_field]-0-[underline_image]", options: nil, metrics: nil, views: viewsDictionary)
        
        self.addConstraints(labelInputHorizontalConstraints)
        self.addConstraints(labelVerticalConstraints)
        self.addConstraints(underlineImageHorizontalConstraints)
        self.addConstraints(underlineImageVerticalConstraints)
        self.addConstraints(monthsLabelVertialConstraints)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize(label: String, value: Int) {
        self.labelField.text = label
        self.inputField.text = "\(value)"
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if let d = inputCellFormDelegate {
            d.inputFieldDidBeginEditing(textField)
        }
    }
    
    func getInputTextField() -> UITextField {
        return inputField
    }
    
    func clearInput() {
        inputField.text = ""
    }
    
}

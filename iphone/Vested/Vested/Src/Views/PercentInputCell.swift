//
//  PercentInputCell.swift
//  Vested
//
//  Created by ncurtis on 1/13/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class PercentInputCell : UITableViewCell, UITextFieldDelegate, FormCell {
    
    let labelField = UILabel()
    let underlineImage = UIImageView(image: UIImage(named: "input_cell_line"))
    let inputField = UITextField()
    let percentLabel = UILabel()
    var inputCellFormDelegate : InputCellFormDelegate?
    var swipeLeftToClearGestureRecognizer: UISwipeGestureRecognizer!
    
    
    class var REUSE_IDENTIFIER : String {
        return "percent_input_cell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        swipeLeftToClearGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "clearInput")
        swipeLeftToClearGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeLeftToClearGestureRecognizer)
        
        percentLabel.font = UIFont(name: "AvenirNext-Medium", size: 26)
        percentLabel.text = "%"
        percentLabel.tintColor = UIColor.whiteColor()
        percentLabel.textColor = UIColor.whiteColor()
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        labelField.translatesAutoresizingMaskIntoConstraints = false
        labelField.font = UIFont(name: "AvenirNext-Medium", size: 16)
        labelField.text = "Label"
        labelField.tintColor = UIColor.whiteColor()
        labelField.textColor = UIColor.whiteColor()
        
        underlineImage.translatesAutoresizingMaskIntoConstraints = false
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
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
        self.addSubview(percentLabel)
        
        let viewsDictionary = ["label_field": labelField, "underline_image": underlineImage, "input_field": inputField, "percent_label": percentLabel]
        let labelInputHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label_field]-[input_field(==70)]-2-[percent_label]-10-|", options: [], metrics: nil, views: viewsDictionary)
        let labelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[label_field]", options: [], metrics: nil, views: viewsDictionary)
        let underlineImageHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[underline_image(==140)]-0-|", options: [], metrics: nil, views: viewsDictionary)
        let underlineImageVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[input_field]-0-[underline_image]", options: [], metrics: nil, views: viewsDictionary)
        let percentLabelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[percent_label]", options: [], metrics: nil, views: viewsDictionary)
        
        self.addConstraints(labelInputHorizontalConstraints)
        self.addConstraints(labelVerticalConstraints)
        self.addConstraints(underlineImageHorizontalConstraints)
        self.addConstraints(underlineImageVerticalConstraints)
        self.addConstraints(percentLabelVerticalConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize(label: String, value: Double) {
        self.labelField.text = label
        let val = round(value * 10) / 10
        self.inputField.text = "\(value)"
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        if let d = inputCellFormDelegate {
            d.inputFieldDidBeginEditing(textField)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let text = textField.text {
            let acceleration = round((text as NSString).doubleValue * 10) / 10
            textField.text = "\(acceleration)"
        }
    }
    
    func getInputTextField() -> UITextField {
        return inputField
    }
    
    func clearInput() {
        inputField.text = ""
    }
    
}

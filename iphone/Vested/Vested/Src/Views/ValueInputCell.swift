//
//  ValueInputCell.swift
//  Vested
//
//  Created by ncurtis on 1/12/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

protocol InputCellFormDelegate {

    func inputFieldDidBeginEditing(textField: UITextField)
    
}

class ValueInputCell : UITableViewCell, UITextFieldDelegate {
    
    let labelField = UILabel()
    let underlineImage = UIImageView(image: UIImage(named: "input_cell_line"))
    let inputField = UITextField()
    var inputCellFormDelegate : InputCellFormDelegate?
    
    class var REUSE_IDENTIFIER : String {
        return "value_input_cell"
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None

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
    
        let viewsDictionary : [NSObject: AnyObject] = ["label_field": labelField, "underline_image": underlineImage, "input_field": inputField]
        let labelInputHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label_field]-[input_field(==135)]-10-|", options: nil, metrics: nil, views: viewsDictionary)
        let labelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[label_field]", options: nil, metrics: nil, views: viewsDictionary)
        let underlineImageHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[underline_image(==140)]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        let underlineImageVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[input_field]-0-[underline_image]", options: nil, metrics: nil, views: viewsDictionary)
        
        self.addConstraints(labelInputHorizontalConstraints)
        self.addConstraints(labelVerticalConstraints)
        self.addConstraints(underlineImageHorizontalConstraints)
        self.addConstraints(underlineImageVerticalConstraints)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func customize(label: String, value: Int) {
        self.labelField.text = label
        self.inputField.text = "\(value)"
    }
    
    func customize(label: String, string value: String) {
        self.labelField.text = label
        self.inputField.text = value
    }
    
    func hideUnderline() {
        self.underlineImage.hidden = true
    }
    
    func showUnderline() {
        self.underlineImage.hidden = false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if let d = inputCellFormDelegate {
            println("began editing")
            d.inputFieldDidBeginEditing(textField)
        }
    }
    
}


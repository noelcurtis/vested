//
//  PriceInputCell.swift
//  Vested
//
//  Created by Scott Penrose on 10/23/15.
//  Copyright © 2015 noelcurtis. All rights reserved.
//

import UIKit

class PriceInputCell: UITableViewCell, UITextFieldDelegate, FormCell {
    
    let labelField = UILabel()
    let underlineImage = UIImageView(image: UIImage(named: "input_cell_line"))
    let inputField = UITextField()
    var inputCellFormDelegate : InputCellFormDelegate?
    var swipeLeftToClearGestureRecognizer: UISwipeGestureRecognizer!
    
    var priceString = ""
    var price: Double {
        return (Double(priceString) ?? 0.0) / 100
    }
   
    class var REUSE_IDENTIFIER : String {
        return "price_input_cell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        swipeLeftToClearGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "clearInput")
        swipeLeftToClearGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeLeftToClearGestureRecognizer)
        
        labelField.translatesAutoresizingMaskIntoConstraints = false
        labelField.font = UIFont(name: "AvenirNext-Medium", size: 16)
        labelField.text = "Label"
        labelField.tintColor = UIColor.whiteColor()
        labelField.textColor = UIColor.whiteColor()
        
        underlineImage.translatesAutoresizingMaskIntoConstraints = false
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.font = UIFont(name: "AvenirNext-Medium", size: 26)
        inputField.text = "50"
        inputField.tintColor = UIColor.whiteColor()
        inputField.textColor = UIColor.whiteColor()
        inputField.textAlignment = NSTextAlignment.Right
        inputField.keyboardType = .NumberPad
        inputField.delegate = self
        
        self.addSubview(labelField)
        self.addSubview(inputField)
        self.addSubview(underlineImage)
        
        let viewsDictionary = ["label_field": labelField, "underline_image": underlineImage, "input_field": inputField]
        let labelInputHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label_field]-[input_field(==135)]-10-|", options: [], metrics: nil, views: viewsDictionary)
        let labelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[label_field]", options: [], metrics: nil, views: viewsDictionary)
        let underlineImageHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[underline_image(==140)]-0-|", options: [], metrics: nil, views: viewsDictionary)
        let underlineImageVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[input_field]-0-[underline_image]", options: [], metrics: nil, views: viewsDictionary)
        
        self.addConstraints(labelInputHorizontalConstraints)
        self.addConstraints(labelVerticalConstraints)
        self.addConstraints(underlineImageHorizontalConstraints)
        self.addConstraints(underlineImageVerticalConstraints)
    }
    
    func turnOffGestures() {
        self.removeGestureRecognizer(swipeLeftToClearGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize(label: String, value: Double) {
        self.labelField.text = label
        if let val = currencyNumberFormatter.stringFromNumber(value) {
            self.inputField.text = val
        } else {
            self.inputField.text = "0"
        }
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
            d.inputFieldDidBeginEditing(textField)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty && range.length > 0 {
            priceString = String(priceString.characters.dropLast())
        } else {
            priceString.appendContentsOf(string)
        }
        textField.text = currencyNumberFormatter.stringFromNumber(price)
        return false
    }
    
    func getInputTextField() -> UITextField {
        return inputField
    }
    
    func clearInput() {
        inputField.text = ""
    }
    
}

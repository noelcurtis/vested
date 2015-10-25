//
//  InputCell.swift
//  Vested
//
//  Created by ncurtis on 1/11/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class PlanNameInputCell : UITableViewCell, UITextFieldDelegate, FormCell {

    let titleInputField = UITextField()
    let underLineImageView = UIImageView(image: UIImage(named: "title_line"))
    class var REUSE_IDENTIFIER : String {
        return "plan_name_input_cell"
    }
    var inputCellFormDelegate : InputCellFormDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        underLineImageView.translatesAutoresizingMaskIntoConstraints = false

        titleInputField.translatesAutoresizingMaskIntoConstraints = false
        titleInputField.font = UIFont(name: "AvenirNext-Medium", size: 26)
        titleInputField.text = "Plan Name"
        titleInputField.tintColor = UIColor.whiteColor()
        titleInputField.textColor = UIColor.whiteColor()
        titleInputField.delegate = self
        titleInputField.clearButtonMode = UITextFieldViewMode.WhileEditing

        self.addSubview(titleInputField)
        
        let viewsDictionary = ["input_field": titleInputField, "underline_image": underLineImageView]
        let labelHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[input_field]-10-|", options: [], metrics: nil, views: viewsDictionary)
        let labelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[input_field]-0-|", options: [], metrics: nil, views: viewsDictionary)
        
        self.addConstraints(labelHorizontalConstraints)
        self.addConstraints(labelVerticalConstraints)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if let d = inputCellFormDelegate {
            d.inputFieldDidBeginEditing(textField)
        }
    }
    
    func getInputTextField() -> UITextField {
        return titleInputField
    }
}

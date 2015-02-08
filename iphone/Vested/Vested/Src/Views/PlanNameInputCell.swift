//
//  InputCell.swift
//  Vested
//
//  Created by ncurtis on 1/11/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class PlanNameInputCell : UITableViewCell, UITextFieldDelegate {

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
        
        underLineImageView.setTranslatesAutoresizingMaskIntoConstraints(false)

        titleInputField.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleInputField.font = UIFont(name: "AvenirNext-Medium", size: 26)
        titleInputField.text = "Plan Name"
        titleInputField.tintColor = UIColor.whiteColor()
        titleInputField.textColor = UIColor.whiteColor()
        titleInputField.delegate = self

        self.addSubview(titleInputField)
        
        let viewsDictionary : [NSObject: AnyObject] = ["input_field": titleInputField, "underline_image": underLineImageView]
        let labelHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[input_field]-10-|", options: nil, metrics: nil, views: viewsDictionary)
        self.addConstraints(labelHorizontalConstraints)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if let d = inputCellFormDelegate {
            d.inputFieldDidBeginEditing(textField)
        }
    }
}

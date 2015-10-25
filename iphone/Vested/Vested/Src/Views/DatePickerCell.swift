//
//  DatePickerCell.swift
//  Vested
//
//  Created by ncurtis on 1/20/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import Foundation
import UIKit

class DatePickerCell : UITableViewCell {
    
    let datePicker: UIDatePicker = UIDatePicker()
    
    class var REUSE_IDENTIFIER : String {
        return "date_picker_cell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.date = NSDate()
        
        self.addSubview(datePicker)
        
        let viewsDictionary = ["date_picker": datePicker]
        
        let vConstraint1 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[date_picker]-0-|", options: [], metrics: nil, views: viewsDictionary)
        let hConstraint1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[date_picker]-0-|", options: [], metrics: nil, views: viewsDictionary)
        
        self.addConstraints(vConstraint1)
        self.addConstraints(hConstraint1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize(date: NSDate) {
        datePicker.date = date
    }
}
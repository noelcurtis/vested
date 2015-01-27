//
//  RestrictedPlanDetailViewController.swift
//  Vested
//
//  Created by ncurtis on 1/10/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class RestrictedPlanDetailViewController: UITableViewController, UITextFieldDelegate {

    var backButton: UIBarButtonItem!
    var checkButton: UIBarButtonItem!
    let restrictedStockOptionDao = RestrictedOptionGrantDao(managedObjectContext: PersistenceService.sharedInstance.managedObjectContext!)
    var restrictedOptionGrant: RestrictedOptionGrant = RestrictedOptionGrant().withDefaults()
    var datePickerShown = false
    var activeTextField: UITextField?
    lazy var dateTimeFormatter: NSDateFormatter  = {
        let dt = NSDateFormatter()
        dt.dateStyle = NSDateFormatterStyle.ShortStyle
        dt.timeStyle = NSDateFormatterStyle.NoStyle
        return dt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShown", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupNavBar() {
        // setup the buttons
        backButton = UIBarButtonItem(image: UIImage(named: "back_button"), style: UIBarButtonItemStyle.Plain, target: self, action: "popViewController")
        checkButton = UIBarButtonItem(image: UIImage(named: "check_button"), style: UIBarButtonItemStyle.Plain, target: self, action: "addPlanAndPopViewController")
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = checkButton
        
        // nav title image
        let navTitle = UIImage(named: "nav_title_vested")
        let navTitleView = UIImageView(image: navTitle)
        self.navigationItem.titleView = navTitleView
        self.navigationItem.titleView?.hidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

    }
    
    func setupTableView() {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        tableView.registerClass(PlanNameInputCell.self, forCellReuseIdentifier: PlanNameInputCell.REUSE_IDENTIFIER)
        tableView.registerClass(ValueInputCell.self, forCellReuseIdentifier: ValueInputCell.REUSE_IDENTIFIER)
        tableView.registerClass(MonthsInputCell.self, forCellReuseIdentifier: MonthsInputCell.REUSE_IDENTIFIER)
        tableView.registerClass(PercentInputCell.self, forCellReuseIdentifier: PercentInputCell.REUSE_IDENTIFIER)
        tableView.registerClass(DatePickerCell.self, forCellReuseIdentifier: DatePickerCell.REUSE_IDENTIFIER)
    }
    
    func popViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addPlanAndPopViewController() {
        let restrictedStockPlan = getStockPlanFromCells()
        self.restrictedStockOptionDao.createStockPlan(restrictedStockPlan)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: -UITextViewDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 2 && indexPath.row == 1) {
            if (datePickerShown) {
                hideDatePicker()
            } else {
                showDatePicker()
            }
        }
    }
    
    // MARK: - UITableViewDatasource
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch(section) {
            case 1: return getSectionHeader("Plan Parameters")
            case 2: return getSectionHeader("Individual Parameters")
            default: return UIView()
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch(section) {
            case 0: return 1.0
            default: return 26
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 1) {
            return 26
        } else {
            return 1.0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.section) {
            case 0: return 36
            case 1: return 37
            case 2: return indexPath.row == 2 ? 130 : 37
            default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
            case 0: return 1
            case 1: return 4
            case 2: return datePickerShown ? 3 : 2
            default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            
            return getPlanNameInputCell("Plan Name")
            
        } else if(indexPath.section == 1) {
            
            switch(indexPath.row) {
                case 0: return getPercentInputCell("Starting Acceleration", value: self.restrictedOptionGrant.startingAcceleration)
                case 1: return getMonthsInputCell("Cliff", value: self.restrictedOptionGrant.cliff)
                case 2: return getMonthsInputCell("Vesting Period", value: self.restrictedOptionGrant.vestingPeriod)
                case 3: return getPercentInputCell("Ending Acceleration", value: self.restrictedOptionGrant.endingAcceleration)
                default: return self.tableView.dequeueReusableCellWithIdentifier(ValueInputCell.REUSE_IDENTIFIER) as ValueInputCell
            }
            
        } else {
            
            switch(indexPath.row) {
                case 0: return getValueInputCell("Grant Shares", value: self.restrictedOptionGrant.shares)
                case 1: return getDateCell("Start Date", string: dateTimeFormatter.stringFromDate(self.restrictedOptionGrant.startDate))
                case 2: return getDatepickerCell(self.restrictedOptionGrant.startDate)
                default: return self.tableView.dequeueReusableCellWithIdentifier(ValueInputCell.REUSE_IDENTIFIER) as ValueInputCell
            }
            
        }
    }
    
    func getDatepickerCell(date: NSDate) -> DatePickerCell {
        let cell: DatePickerCell = self.tableView.dequeueReusableCellWithIdentifier(DatePickerCell.REUSE_IDENTIFIER) as DatePickerCell
        cell.customize(date)
        cell.datePicker.addTarget(self, action: Selector("dateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        return cell
    }
    
    func getPlanNameInputCell(name: String) -> PlanNameInputCell {
        let cell: PlanNameInputCell = self.tableView.dequeueReusableCellWithIdentifier(PlanNameInputCell.REUSE_IDENTIFIER) as PlanNameInputCell
        cell.titleInputField.text = name
        cell.titleInputField.delegate = self
        return cell
    }
    
    func getValueInputCell(label: String, value: Int) -> ValueInputCell {
        let cell: ValueInputCell = self.tableView.dequeueReusableCellWithIdentifier(ValueInputCell.REUSE_IDENTIFIER) as ValueInputCell
        cell.customize(label, value: value)
        cell.inputField.delegate = self
        return cell
    }
    
    func getValueInputCell(label: String, string value: String) -> ValueInputCell {
        let cell: ValueInputCell = self.tableView.dequeueReusableCellWithIdentifier(ValueInputCell.REUSE_IDENTIFIER) as ValueInputCell
        cell.customize(label, string: value)
        cell.inputField.delegate = self
        return cell
    }
    
    func getDateCell(label: String, string value: String) -> ValueInputCell {
        let cell: ValueInputCell = self.tableView.dequeueReusableCellWithIdentifier(ValueInputCell.REUSE_IDENTIFIER) as ValueInputCell
        cell.customize(label, string: value)
        cell.inputField.enabled = false
        return cell
    }
    
    func getMonthsInputCell(label: String, value: Int) -> MonthsInputCell {
        let cell: MonthsInputCell = self.tableView.dequeueReusableCellWithIdentifier(MonthsInputCell.REUSE_IDENTIFIER) as MonthsInputCell
        cell.customize(label, value: value)
        cell.inputField.delegate = self
        return cell
    }
    
    func getPercentInputCell(label: String, value: Double) -> PercentInputCell {
        let cell: PercentInputCell = self.tableView.dequeueReusableCellWithIdentifier(PercentInputCell.REUSE_IDENTIFIER) as PercentInputCell
        cell.customize(label, value: value)
        cell.inputField.delegate = self
        return cell
    }
    
    func getStockPlanFromCells() -> StockPlan {
        let r = RestrictedOptionGrant()
        
        if let startAccelerationCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) {
            let a = startAccelerationCell as PercentInputCell
            r.startingAcceleration = (a.inputField.text as NSString).doubleValue
        }
        
        if let cliffCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) {
            let a = cliffCell as MonthsInputCell
            r.cliff = (a.inputField.text as NSString).integerValue
        }

        if let vestingPeriodCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1)) {
            let a = vestingPeriodCell as MonthsInputCell
            r.vestingPeriod = (a.inputField.text as NSString).integerValue
        }

        if let endingAccelerationCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 1)) {
            let a = endingAccelerationCell as PercentInputCell
            r.endingAcceleration = (a.inputField.text as NSString).doubleValue
        }

        if let grantSharesCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) {
            let a = grantSharesCell as ValueInputCell
            r.shares = (a.inputField.text as NSString).integerValue
        }

        if let startDateCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2)) {
            let a = startDateCell as ValueInputCell
            if let date : NSDate = dateTimeFormatter.dateFromString(a.inputField.text) {
                r.startDate = date
            }
        }
        
        if let nameCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) {
            let a = nameCell as PlanNameInputCell
            r.name = a.titleInputField.text
        }
        
        return r
    }
    
    func getSectionHeader(label: String) -> UIView {
        let baseView = UIView()
        baseView.addSubview(UIImageView(image: UIImage(named: "form_title_background")))
        let labelField = UILabel()
        labelField.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelField.font = UIFont(name: "AvenirNext-Medium", size: 20)
        labelField.text = label
        labelField.textColor = UIColor(rgba: "#4C6DFE")
        baseView.addSubview(labelField)
        
        let viewsDictionary : [NSObject: AnyObject] = ["label_field": labelField]
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label_field]", options: nil, metrics: nil, views: viewsDictionary)
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label_field]-0-|", options: nil, metrics: nil, views: viewsDictionary)
        
        baseView.addConstraints(hConstraints)
        baseView.addConstraints(vConstraints)
        
        return baseView
    }
    
    func showDatePicker() {
        println("Showing date picker")
        datePickerShown = true
        activeTextField?.resignFirstResponder()
        (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2)) as ValueInputCell).hideUnderline()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 2)], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func hideDatePicker() {
        println("Hiding date picker")
        datePickerShown = false
        (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2)) as ValueInputCell).showUnderline()
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 2)], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func keyboardShown() {
        if (datePickerShown) {
            hideDatePicker()
        }
    }
    
    func dateChanged(datePicker: UIDatePicker) {
        (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2)) as ValueInputCell).inputField.text = dateTimeFormatter.stringFromDate(datePicker.date)
    }
}

//
//  RestrictedPlanDetailViewController.swift
//  Vested
//
//  Created by ncurtis on 1/10/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class RestrictedPlanDetailViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var backButton: UIBarButtonItem!
    var checkButton: UIBarButtonItem!
    let restrictedStockOptionDao = RestrictedOptionGrantDao(managedObjectContext: PersistenceService.sharedInstance.managedObjectContext!)
    var restrictedOptionGrant: RestrictedOptionGrant = RestrictedOptionGrant().withDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
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
    }
    
    func popViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addPlanAndPopViewController() {
        let restrictedStockPlan = getStockPlanFromCells()
        self.restrictedStockOptionDao.createStockPlan(restrictedStockPlan)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
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
            default: return 22
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.row) {
            case 0: return 40
            default: return 37
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
            case 0: return 1
            case 1: return 4
            case 2: return 2
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
                case 1: return getValueInputCell("Start Date", string: "WAT")
                default: return self.tableView.dequeueReusableCellWithIdentifier(ValueInputCell.REUSE_IDENTIFIER) as ValueInputCell
            }
            
        }
    }
    
    func getPlanNameInputCell(name: String) -> PlanNameInputCell {
        let cell: PlanNameInputCell = self.tableView.dequeueReusableCellWithIdentifier(PlanNameInputCell.REUSE_IDENTIFIER) as PlanNameInputCell
        cell.titleInputField.text = name
        return cell
    }
    
    func getValueInputCell(label: String, value: Int) -> ValueInputCell {
        let cell: ValueInputCell = self.tableView.dequeueReusableCellWithIdentifier(ValueInputCell.REUSE_IDENTIFIER) as ValueInputCell
        cell.customize(label, value: value)
        return cell
    }
    
    func getValueInputCell(label: String, string value: String) -> ValueInputCell {
        let cell: ValueInputCell = self.tableView.dequeueReusableCellWithIdentifier(ValueInputCell.REUSE_IDENTIFIER) as ValueInputCell
        cell.customize(label, string: value)
        return cell
    }
    
    func getMonthsInputCell(label: String, value: Int) -> MonthsInputCell {
        let cell: MonthsInputCell = self.tableView.dequeueReusableCellWithIdentifier(MonthsInputCell.REUSE_IDENTIFIER) as MonthsInputCell
        cell.customize(label, value: value)
        return cell
    }
    
    func getPercentInputCell(label: String, value: Double) -> PercentInputCell {
        let cell: PercentInputCell = self.tableView.dequeueReusableCellWithIdentifier(PercentInputCell.REUSE_IDENTIFIER) as PercentInputCell
        cell.customize(label, value: value)
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
//            r.startingAcceleration = (a.inputField.text as NSString)
        }
        
        if let nameCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) {
            let a = nameCell as PlanNameInputCell
            r.name = a.titleInputField.text
        }
        
        return r
    }
    
    func getSectionHeader(label: String) -> UIView {
        let baseView = UIView()
        let labelField = UILabel()
        labelField.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelField.font = UIFont(name: "AvenirNext-Medium", size: 20)
        labelField.text = label
        labelField.textColor = UIColor(rgba: "#50E3C2")
        baseView.addSubview(labelField)
        
        let viewsDictionary : [NSObject: AnyObject] = ["label_field": labelField]
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label_field]", options: nil, metrics: nil, views: viewsDictionary)
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-1-[label_field]-2-|", options: nil, metrics: nil, views: viewsDictionary)
        
        baseView.addConstraints(hConstraints)
        baseView.addConstraints(vConstraints)
        
        return baseView
    }
    
}

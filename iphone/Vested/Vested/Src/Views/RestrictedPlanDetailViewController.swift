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
        checkButton = UIBarButtonItem(image: UIImage(named: "check_button"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
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
        tableView.registerClass(PlanNameInputCell.self, forCellReuseIdentifier: "plan_name_input_cell")
        tableView.registerClass(ValueInputCell.self, forCellReuseIdentifier: "value_input_cell")
        tableView.registerClass(MonthsInputCell.self, forCellReuseIdentifier: "months_input_cell")
        tableView.registerClass(PercentInputCell.self, forCellReuseIdentifier: "percent_input_cell")
    }
    
    func popViewController() {
        self.navigationController?.popToRootViewControllerAnimated(true)
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
            
            return getPlanNameInputCell()
            
        } else if(indexPath.section == 1) {
            
            switch(indexPath.row) {
                case 0: return getPercentInputCell("Starting Acceleration")
                case 1: return getMonthsInputCell("Cliff")
                case 2: return getMonthsInputCell("Vesting Period")
                case 3: return getPercentInputCell("Ending Acceleration")
                default: return self.tableView.dequeueReusableCellWithIdentifier("value_input_cell") as ValueInputCell
            }
            
        } else {
            
            switch(indexPath.row) {
                case 0: return getValueInputCell("Grant Shares")
                case 1: return getValueInputCell("Start Date")
                default: return self.tableView.dequeueReusableCellWithIdentifier("value_input_cell") as ValueInputCell
            }
            
        }
    }
    
    func getPlanNameInputCell() -> PlanNameInputCell {
        return self.tableView.dequeueReusableCellWithIdentifier("plan_name_input_cell") as PlanNameInputCell
    }
    
    func getValueInputCell(label: String) -> ValueInputCell {
        let cell: ValueInputCell = self.tableView.dequeueReusableCellWithIdentifier("value_input_cell") as ValueInputCell
        cell.customize(label, value: 10000)
        return cell
    }
    
    func getMonthsInputCell(label: String) -> MonthsInputCell {
        let cell: MonthsInputCell = self.tableView.dequeueReusableCellWithIdentifier("months_input_cell") as MonthsInputCell
        cell.customize(label, value: 24)
        return cell
    }
    
    func getPercentInputCell(label: String) -> PercentInputCell {
        let cell: PercentInputCell = self.tableView.dequeueReusableCellWithIdentifier("percent_input_cell") as PercentInputCell
        cell.customize(label, value: 10)
        return cell
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

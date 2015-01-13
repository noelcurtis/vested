//
//  RestrictedPlanDetailViewController.swift
//  Vested
//
//  Created by ncurtis on 1/10/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class RestrictedPlanDetailViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        tableView.registerClass(PlanNameInputCell.self, forCellReuseIdentifier: "plan_name_input_cell")
        tableView.registerClass(ValueInputCell.self, forCellReuseIdentifier: "value_input_cell")
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - UITableViewDatasource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
            case 0: return 2
            default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.row) {
            case 0: return self.tableView.dequeueReusableCellWithIdentifier("plan_name_input_cell") as PlanNameInputCell
            default: return self.tableView.dequeueReusableCellWithIdentifier("value_input_cell") as ValueInputCell
        }
    }
    
}

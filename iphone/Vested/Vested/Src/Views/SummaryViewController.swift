//
//  SummaryViewController.swift
//  Vested
//
//  Created by ncurtis on 1/10/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class SummaryViewController : UITableViewController {

    //var menuButton: UIBarButtonItem!
    var addButton: UIBarButtonItem!

    let restrictedStockOptionDao = RestrictedOptionGrantDao(managedObjectContext: PersistenceService.sharedInstance.managedObjectContext!)
    
    var stockPlans = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        stockPlans = restrictedStockOptionDao.findAllRestrictedOptionGrants()
        tableView.reloadData()
    }
    
    func setupNavBar() {
        // setup the buttons
        //menuButton = UIBarButtonItem(image: UIImage(named: "menu_button"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        addButton = UIBarButtonItem(image: UIImage(named: "add_button"), style: UIBarButtonItemStyle.Plain, target: self, action: "pushRestrictedStockPlanDetailView")
        
        // nav title image
        let navTitle = UIImage(named: "nav_title_vested")
        let navTitleView = UIImageView(image: navTitle)
        self.navigationItem.titleView = navTitleView
        self.navigationItem.titleView?.hidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //self.navigationItem.leftBarButtonItem = menuButton
        self.navigationItem.rightBarButtonItem = addButton
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#252A2D")
        self.navigationController?.navigationBar.translucent = false
    }
    
    func pushRestrictedStockPlanDetailView() {
        self.navigationController?.pushViewController(RestrictedPlanDetailViewController(style: UITableViewStyle.Grouped), animated: true)
    }

    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - UITableViewDatasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockPlans.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("summary_cell") as UITableViewCell?
        if let cell = c {
            cell.textLabel?.text = (stockPlans[indexPath.row] as RestrictedOptionGrant).name
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "summary_cell")
            cell.textLabel?.text = (stockPlans[indexPath.row] as RestrictedOptionGrant).name
            return cell
        }
        
    }
}

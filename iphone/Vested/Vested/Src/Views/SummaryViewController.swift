//
//  SummaryViewController.swift
//  Vested
//
//  Created by ncurtis on 1/10/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class SummaryViewController : UITableViewController {

    var addButton: UIBarButtonItem!

    let restrictedStockOptionDao = RestrictedOptionGrantDao(managedObjectContext: PersistenceService.sharedInstance.managedObjectContext!)
    let restrictedStockVestingCalulator = RestrictedStockOptionGrantCalculator()
    
    var stockPlans = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }
    
    override func viewDidAppear(animated: Bool) {
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        tableView.registerClass(SummaryCellV2.self, forCellReuseIdentifier: SummaryCellV2.REUSE_IDENTIFIER)
        
        stockPlans = restrictedStockOptionDao.findAllRestrictedOptionGrants()
        tableView.reloadData()
    }
    
    func setupNavBar() {
        // setup the buttons
        addButton = UIBarButtonItem(image: UIImage(named: "add_button"), style: UIBarButtonItemStyle.Plain, target: self, action: "pushRestrictedStockPlanDetailView")
        
        // nav title image
        let navTitle = UIImage(named: "nav_title_vested")
        let navTitleView = UIImageView(image: navTitle)
        self.navigationItem.titleView = navTitleView
        self.navigationItem.titleView?.hidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = addButton
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#252A2D")
        self.navigationController?.navigationBar.translucent = false
    }
    
    func pushRestrictedStockPlanDetailView() {
        self.navigationController?.pushViewController(RestrictedPlanDetailViewController(style: UITableViewStyle.Grouped), animated: true)
    }

    // MARK: - UITableViewDelegate
    
    
    // MARK: - UITableViewDatasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockPlans.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return getSummaryCell(indexPath)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 99
    }
    
    func getSummaryCell(indexPath: NSIndexPath) -> UITableViewCell {
        let stockPlan = stockPlans[indexPath.row] as RestrictedOptionGrant
        let vestingResult = restrictedStockVestingCalulator.calculate(stockPlan)
        
        let summaryCell = tableView.dequeueReusableCellWithIdentifier(SummaryCellV2.REUSE_IDENTIFIER) as SummaryCellV2
        summaryCell.customize(stockPlan, vestingResult: vestingResult)
        return summaryCell
    }
}



























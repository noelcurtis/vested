//
//  SummaryViewController.swift
//  Vested
//
//  Created by ncurtis on 1/10/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import UIKit

class SummaryViewController : UITableViewController, CellDetailButtonDelegate {

    var addButton: UIBarButtonItem!

    let restrictedStockOptionDao = RestrictedOptionGrantDao(managedObjectContext: PersistenceService.sharedInstance.managedObjectContext!)
    let restrictedStockVestingCalulator = RestrictedStockOptionGrantCalculator()
    
    var stockPlans = []
    var expandedIndexPaths:[NSIndexPath] = []
    
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
        if (expandedIndexPaths.filter({$0 == indexPath}).count != 0) {
            return SizeClass.getClassForSize().rowHeightExpanded
        } else {
            return SizeClass.getClassForSize().rowHeight
        }
    }
    
    func getSummaryCell(indexPath: NSIndexPath) -> UITableViewCell {
        let stockPlan = stockPlans[indexPath.row] as RestrictedOptionGrant
        let vestingResult = restrictedStockVestingCalulator.calculate(stockPlan)
        
        let summaryCell = tableView.dequeueReusableCellWithIdentifier(SummaryCellV2.REUSE_IDENTIFIER) as SummaryCellV2
        summaryCell.customize(stockPlan, vestingResult: vestingResult, indexPath: indexPath)
        summaryCell.cellDetailButtonPressedDelegate = self
        return summaryCell
    }
    
    func detailButtonPressed(cell: UITableViewCell) {
        if let indexPath = (cell as SummaryCellV2).indexPath {
            
            // check if the cell at indexPath is already expanded
            if (expandedIndexPaths.filter({$0 == indexPath}).count != 0) {
                // if its already expanded remove it so it can be contracted
                expandedIndexPaths = expandedIndexPaths.filter({$0 != indexPath})
                (cell as SummaryCellV2).contractDetailView()
                tableView.reloadData()
            } else {
                // if its not already expanded add it to the expanded list
                expandedIndexPaths.append(indexPath)
                tableView.reloadData()
                (cell as SummaryCellV2).expandDetailView()
            }
        
            
        } else {
            NSLog("Cell has no index path, no displaying summary detail")
        }
    }
    
}



























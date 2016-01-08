//
//  PrizesViewController.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 08/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import UIKit
import Neon

class PrizesViewController: UITableViewController {
    var prizes : [PrizeModel] = []
    
    func updatePrizesTable(new_prizes : [PrizeModel]) -> Void {
        prizes = new_prizes
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Prizes"
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: .ValueChanged)
        PrizesApiController.getPrizes() {
            result in
            print("completion handler")
            self.refreshPrizes(result)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return prizes.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PrizeCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("prizeCell", forIndexPath: indexPath) as! PrizeCell
        let prize = prizes[indexPath.row]
        
        // Views
        let cellContainer = UIView()
        let imageContainer = UIView()
        let contentContainer = UIView()
        let newTitleLabel = UILabel()
        let newFreeSlotsLabel = UILabel()
        let newTotalSlotsLabel = UILabel()
        
        // View hierarchy
        cell.addSubview(cellContainer)
        cellContainer.addSubview(imageContainer)
        cellContainer.addSubview(contentContainer)
        contentContainer.addSubview(newTitleLabel)
        contentContainer.addSubview(newFreeSlotsLabel)
        contentContainer.addSubview(newTotalSlotsLabel)

        // fonts
        newTitleLabel.font = UIFont(name: "Aleo-Bold", size: FontSizes.large)
        newFreeSlotsLabel.font = UIFont(name: "Aleo-Regular", size: FontSizes.medium)
        newTotalSlotsLabel.font = UIFont(name: "Aleo-Regular", size: FontSizes.small)
        
        // Content
        newTitleLabel.text = prize.title
        newFreeSlotsLabel.text = String(prize.free_slots) + " Available"
        newTotalSlotsLabel.text = "From " + String(prize.total_slots)
        
        // other formating
        newTitleLabel.numberOfLines = 0
        
        // Layout
        cellContainer.fillSuperview(left: 5, right: 5, top: 5, bottom: 5)
        imageContainer.anchorAndFillEdge(.Left, xPad: 0, yPad: 0, otherSize: cellContainer.height)
        contentContainer.anchorAndFillEdge(.Right, xPad: 0, yPad: 0, otherSize: cellContainer.width - cellContainer.height)
        newTitleLabel.anchorInCorner(.TopLeft, xPad: 18, yPad: 18, width: contentContainer.width * 0.7, height: AutoHeight)
        newFreeSlotsLabel.anchorInCorner(.BottomLeft, xPad: 18, yPad: 18, width: contentContainer.width * 0.45, height: AutoHeight)
        newTotalSlotsLabel.alignAndFillWidth(align: .ToTheRightMatchingBottom, relativeTo: newFreeSlotsLabel, padding: 18, height: AutoHeight)
        
        // colors
        newTitleLabel.textColor = Colors.darkFont
        newFreeSlotsLabel.textColor = Colors.primary
        newTotalSlotsLabel.textColor = Colors.lightFont
        imageContainer.backgroundColor = Colors.lightFont
        contentContainer.backgroundColor = Colors.secondary
        cellContainer.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func refreshPrizes(result : String) -> Void {
        print("handling completion")
        if result == "success" {
            print("process success")
            let fetchedPrizes = PrizeCollection.fetchFromRealm()
            print("fetched")
            print(fetchedPrizes)
            print("fetched")
            if fetchedPrizes != nil {
                self.prizes = fetchedPrizes!
            }
            self.tableView.reloadData()
        } else if result == "error" {
            print("process error")
            let alertController = UIAlertController(title: "Connection failed", message: "We're not able to connect to the server at the moment", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Mkay", style: .Default) {
                (action) in
                alertController .dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        self.refreshControl!.endRefreshing()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        print("refreshing")
        PrizesApiController.getPrizes() {
            result in
            self.refreshPrizes(result)
        }
    }
}

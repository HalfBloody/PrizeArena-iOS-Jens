//
//  PrizesViewController.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 08/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import UIKit

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
        self.refreshControl?.addTarget(self, action: Selector("handleRefresh"), forControlEvents: .ValueChanged)
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
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        let boxView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 90))
        boxView.backgroundColor = Colors.lightFont
        boxView.layer.masksToBounds = false
        boxView.layer.cornerRadius = 2.0
        boxView.layer.shadowOffset = CGSizeMake(-1, 1)
        boxView.layer.shadowOpacity = 0.2
        cell.contentView.addSubview(boxView)
        cell.contentView.sendSubviewToBack(boxView)
        cell.titleLabel.text = prize.title
        cell.freeSlotsLabel.text = String(prize.free_slots) + " Available"
        cell.totalSlotsLabel.text = "From " + String(prize.total_slots)
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

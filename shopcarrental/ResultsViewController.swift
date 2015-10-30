//
//  ViewController.swift
//  shopcarrental
//
//  Created by Sawyer Vaughan on 10/26/15.
//  Copyright © 2015 Sawyer Vaughan. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    var results = Array<HotwireResult>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(HotwireResultCell.self, forCellReuseIdentifier: Strings.hotwire_cell_identifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let search = UIBarButtonItem(title: Strings.search, style: .Done, target: self, action: "search")
        self.navigationItem.rightBarButtonItem = search
        self.navigationItem.title = Strings.results_view_controller_title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func search() {
        let searchController = SearchViewController(resultsController: self)
        let navController = UINavigationController(rootViewController: searchController)
        self.navigationController?.presentViewController(navController, animated: true, completion: nil)
    }
    
    func searchResults(destination: String, startDate: String, endDate: String, pickupTime: String, dropoffTime: String) {
        // clear search results
        self.results.removeAll()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        
        // search
        let req = HotwireRequester()
        req.requestFromHotwire(destination, startDate: startDate, endDate: endDate, pickupTime: pickupTime, dropoffTime: dropoffTime, callback: { results in
            if results != nil {
                self.results = results!
                
                // should reload results on main thread
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            } else {
                // do error showing here
            }
        })
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HotwireResultCell.getHeightForResult(self.results[indexPath.row])
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // show a web view controller with the link
        let webController = WebViewController(title: Strings.web_view_controller_title, url: NSURL(string: self.results[indexPath.row].link)!)
        let navController = UINavigationController(rootViewController: webController)
        self.navigationController?.presentViewController(navController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create the cell for a location
        var cell : HotwireResultCell? = tableView.dequeueReusableCellWithIdentifier(Strings.hotwire_cell_identifier) as! HotwireResultCell?
        if cell == nil {
            cell = HotwireResultCell(style: .Default, reuseIdentifier: Strings.hotwire_cell_identifier)
        }
        
        cell!.configureCell(self.results[indexPath.row], tableView: self.tableView)
        
        return cell!
    }
}


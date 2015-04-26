//
//  CombinedViewController.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftSpinner

class CombinedViewController: UITableViewController {
    
    var majors: [Major] = [Major]()
    var searchArray:[Major] = [Major]() {
        didSet {self.tableView.reloadData()}
    }
    var combinedSearchController = UISearchController()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Acquiring data...")
        NetworkManager.getMajors({ (json: JSON) -> Void in
            //The `index` is 0..<json.count's string value
            for (index: String, major: JSON) in json {
                var maj: Major = Major()
                maj.name = major["name"].stringValue
                maj.abbr = major["abbr"].stringValue
                maj.id = major["major_id"].stringValue
                if (maj.name != "") {
                    self.majors.append(maj)
                }
            }
            
            self.tableView.reloadData()
            SwiftSpinner.hide()
        })
        
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if firstLaunch {
            // Client has launched before
        } else {
            println("First launch. Setting NSUserDefaults(FirstLaunch).")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            self.performSegueWithIdentifier("firstLaunch", sender: self)
        }
        
        // Configure countryTable
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.definesPresentationContext = true
        
        // Configure combinedSearchController
        self.combinedSearchController = ({
            // Two setups provided below:
            
            // Setup One: This setup present the results in the current view.
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = sender as? NSIndexPath {
            let major = (self.combinedSearchController.active ? searchArray[indexPath.row] : majors[indexPath.row]) as Major
            if segue.identifier == "CombinedToMajor" {
                (segue.destinationViewController as! MajorViewController).detailItem = major
            } else if segue.identifier == "CombinedToCourse" {
                let course = searchArray[indexPath.row]
                (segue.destinationViewController as! CourseViewController).detailItem = course
            }
        }
    }
    
}


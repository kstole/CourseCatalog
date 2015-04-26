//
//  CombinedViewController.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import UIKit
import SwiftyJSON

class CombinedViewController: UITableViewController {

    @IBOutlet var majorCourseTable: UITableView!
    var majors: [Major] = [Major]()
    var courses = ["CS 160","CS 261"]
    var searchArray:[Major] = [Major]() {
        didSet  {self.majorCourseTable.reloadData()}
    }
    var combinedSearchController = UISearchController()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.getMajors({ (json: JSON) -> Void in
            //The `index` is 0..<json.count's string value
            for (index: String, major: JSON) in json {
                var maj: Major = Major()
                maj.name = major["name"].stringValue
                maj.abbr = major["abbr"].stringValue
                self.majors.append(maj)
            }
            
            self.tableView.reloadData()
        })
        
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if !firstLaunch  {
            self.performSegueWithIdentifier("firstLaunch", sender: self)
        }
        else {
            println("First launch, setting NSUserDefault.")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
        }
        
        // Configure countryTable
        self.majorCourseTable.delegate = self
        self.majorCourseTable.dataSource = self
        
        // Configure countrySearchController
        self.combinedSearchController = ({
            // Two setups provided below:
            
            // Setup One: This setup present the results in the current view.
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            self.majorCourseTable.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.majorCourseTable.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CombinedToMajor" {
            if let indexPath = sender as? NSIndexPath {
                let major = majors[indexPath.row] as Major
                (segue.destinationViewController as! MajorViewController).detailItem = major
            }
        } else if segue.identifier == "CombinedToCourse" {
            if let indexPath = sender as? NSIndexPath {
                let course = courses[indexPath.row] as String
                (segue.destinationViewController as! CourseViewController).detailItem = course
            }
        }
    }
    
}


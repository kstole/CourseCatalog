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

    @IBOutlet var subjectCourseTable: UITableView!
    var subjects = ["Computer Science","Electrical & Computer Engineering","Physics","Mathematics"]
    var courses = ["CS 160","CS 261"]
    var searchArray:[String] = [String]() {
        didSet  {self.subjectCourseTable.reloadData()}
    }
    var combinedSearchController = UISearchController()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.getMajors({ (json: JSON) -> Void in
            println(json)
        })
        
        // Configure countryTable
        self.subjectCourseTable.delegate = self
        self.subjectCourseTable.dataSource = self
        
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
            self.subjectCourseTable.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.subjectCourseTable.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CombinedToSubject" {
            if let indexPath = sender as? NSIndexPath {
                let subject = subjects[indexPath.row] as String
                println("subject: \(subject)")
                (segue.destinationViewController as! SubjectViewController).detailItem = subject
            }
        } else if segue.identifier == "CombinedToCourse" {
            if let indexPath = sender as? NSIndexPath {
                let course = courses[indexPath.row] as String
                (segue.destinationViewController as! CourseViewController).detailItem = course
            }
        }
    }
    
}


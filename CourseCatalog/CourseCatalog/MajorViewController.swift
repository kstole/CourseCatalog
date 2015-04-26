//
//  MajorViewController.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import UIKit

class MajorViewController: UITableViewController {

    @IBOutlet var courseTable: UITableView!
    
    var courses = [Course("160", "Intro to Com Sci"),
        Course("261", "Data Structures"),
        Course("351", "Something else"),
        Course("123", "something new")]
    var searchArray:[Course] = [Course]() {
        didSet {self.courseTable.reloadData()}
    }
    var courseSearchController = UISearchController()
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let major = detail as? Major {
                self.navigationItem.title = major.name
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure courseTable
        self.courseTable.delegate = self
        self.courseTable.dataSource = self
        
        self.definesPresentationContext = true
        
        // Configure courseSearchController
        self.courseSearchController = ({
            // Two setups provided below:
            
            // Setup One: This setup present the results in the current view.
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            self.courseTable.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.configureView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.courseTable.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = sender as? NSIndexPath {
            let course = (self.courseSearchController.active ? searchArray[indexPath.row] : courses[indexPath.row]) as Course
            (segue.destinationViewController as! CourseViewController).detailItem = course
        }
    }


}


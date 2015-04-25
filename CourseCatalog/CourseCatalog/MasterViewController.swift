//
//  MasterViewController.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet var subjectCourseTable: UITableView!
    var subjects = ["Computer Science","Electrical & Computer Engineering","Physics","Mathematics"]
    var searchArray:[String] = [String]() {
        didSet  {self.subjectCourseTable.reloadData()}
    }
    var subjectCourseSearchController = UISearchController()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure countryTable
        self.subjectCourseTable.delegate = self
        self.subjectCourseTable.dataSource = self
        
        // Configure countrySearchController
        self.subjectCourseSearchController = ({
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
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let subject = subjects[indexPath.row] as String
            (segue.destinationViewController as! DetailViewController).detailItem = subject
            }
        }
    }


}


//
//  MajorViewController.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftSpinner

class MajorViewController: UITableViewController {
    
    var courses: [Course] = [Course]()
    var searchArray:[Course] = [Course]() {
        didSet {self.tableView.reloadData()}
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
        if let major: Major = self.detailItem as? Major {
            self.navigationItem.title = major.name
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let major: Major = self.detailItem as? Major {
            SwiftSpinner.show("Acquiring courses...")
            NetworkManager.getClassesWithMajorId(major.id, term: "Sp15") {
                (json: JSON) -> Void in
                println(json)
                //The `index` is 0..<json.count's string value
                for (index: String, course: JSON) in json {
                    var crs: Course = Course()
                    crs.number = course["class_num"].stringValue
                    crs.name = course["class_name"].stringValue
                    crs.id = course["class_id"].stringValue
                    crs.profRating = (course["professor_rating"].stringValue as NSString).floatValue
                    crs.OSUBooksPrice = (course["osu_textbook_total"].stringValue as NSString).floatValue
                    if let major = self.detailItem as? Major {
                        crs.major = major
                    }
                    if (crs.name != "" && crs.name != self.courses.last?.name) {
                        self.courses.append(crs)
                    }
                }
                self.tableView.reloadData()
                SwiftSpinner.hide()
            }
        }
        
        // Configure tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.configureView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = sender as? NSIndexPath {
            let course = (self.courseSearchController.active ? searchArray[indexPath.row] : courses[indexPath.row]) as Course
            (segue.destinationViewController as! CourseViewController).detailItem = course
        }
    }


}


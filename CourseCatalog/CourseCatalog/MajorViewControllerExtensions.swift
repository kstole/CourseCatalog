//
//  MajorViewControllerExtensions.swift
//  SearchController
//
//  Created by Kyler Stole on 17/8/14.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation
import UIKit

extension MajorViewController: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.courses.count == 0 {return 1}
        if (self.courseSearchController.active) {
            return self.searchArray.count
        } else {
            return self.courses.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.courses.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No content to show"
            cell.textLabel?.textAlignment = .Center
            cell.textLabel?.textColor = UIColor.lightGrayColor()
            cell.selectionStyle = .None
            return cell
        } else {
            var cell = self.tableView.dequeueReusableCellWithIdentifier("MajorCell") as! CourseTableViewCell
            let source = (self.courseSearchController.active ? self.searchArray : self.courses)
            cell.courseNum?.text = source[indexPath.row].number
            cell.courseName?.text = source[indexPath.row].name
            
            let adj = 190

            return cell
        }
    }
    
}

extension MajorViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.courses.count != 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.performSegueWithIdentifier("MajorToCourse", sender: indexPath)
        }
    }
}

extension MajorViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.searchArray.removeAll(keepCapacity: false)
        
        if searchController.searchBar.text.isEmpty {
            self.searchArray = self.courses
        } else {
            self.searchArray = self.courses.filter {
                ($0.number as NSString).containsString(searchController.searchBar.text.lowercaseString) ||
                    ($0.name.lowercaseString as NSString).containsString(searchController.searchBar.text.lowercaseString)
            }
        }
    }
}
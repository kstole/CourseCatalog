//
//  CombinedViewControllerExtensions.swift
//  SearchController
//
//  Created by Stuart Breckenridge on 17/8/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import Foundation
import UIKit

extension CombinedViewController: UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (self.combinedSearchController.active) {
            return 1
        } else {
            return 2
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.combinedSearchController.active) {
            return self.searchArray.count
        } else {
            if section == 0 {
                return self.majors.count
            } else {
                return self.courses.count
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.majorCourseTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        if (self.combinedSearchController.active) {
            cell.textLabel?.text! = self.searchArray[indexPath.row].name
            return cell
        } else {
            if indexPath.section == 0 {
                cell.textLabel?.text! = self.majors[indexPath.row].name
            } else {
                cell.textLabel?.text! = self.courses[indexPath.row]
            }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Majors"
        } else if section == 1 {
            return "Courses"
        }
        return nil;
    }
}

extension CombinedViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.combinedSearchController.dismissViewControllerAnimated(false, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            self.performSegueWithIdentifier("CombinedToMajor", sender: indexPath)
        } else {
            self.performSegueWithIdentifier("CombinedToCourse", sender: indexPath)
        }
    }
}

extension CombinedViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.searchArray.removeAll(keepCapacity: false)
        
        if searchController.searchBar.text.isEmpty {
            self.searchArray = self.majors
        } else {
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
            let array = (self.majors as NSArray).filteredArrayUsingPredicate(searchPredicate)
            let filteredArray = self.majors.filter { ($0.name as NSString).containsString(searchController.searchBar.text) }
            self.searchArray = filteredArray as! [Major]
        }
    }
}
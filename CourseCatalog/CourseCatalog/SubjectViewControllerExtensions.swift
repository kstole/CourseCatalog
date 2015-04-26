//
//  SubjectViewControllerExtensions.swift
//  SearchController
//
//  Created by Stuart Breckenridge on 17/8/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import Foundation
import UIKit

extension SubjectViewController: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.courseSearchController.active) {
            return self.searchArray.count
        } else {
            return self.courses.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.courseTable.dequeueReusableCellWithIdentifier("SubjectCell") as! UITableViewCell
        
        if (self.courseSearchController.active) {
            cell.textLabel?.text! = self.searchArray[indexPath.row]
        } else {
            cell.textLabel?.text! = self.courses[indexPath.row]
        }
        return cell
    }
    
}

extension SubjectViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.courseSearchController.dismissViewControllerAnimated(false, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("SubjectToCourse", sender: indexPath)
    }
}

extension SubjectViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.searchArray.removeAll(keepCapacity: false)
        
        if searchController.searchBar.text.isEmpty {
            self.searchArray = self.courses
        } else {
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
            let array = (self.courses as NSArray).filteredArrayUsingPredicate(searchPredicate)
            self.searchArray = array as! [String]
        }
    }
}
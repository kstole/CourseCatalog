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
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.subjectCourseSearchController.active) {
            return self.searchArray.count
        } else {
            return self.subjects.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.subjectCourseTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        if (self.subjectCourseSearchController.active) {
            cell.textLabel?.text! = self.searchArray[indexPath.row]
            return cell
        }
        
        else
        {
            cell.textLabel?.text! = self.subjects[indexPath.row]
            return cell
        }
    }
}

extension CombinedViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension CombinedViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.searchArray.removeAll(keepCapacity: false)
        
        if searchController.searchBar.text.isEmpty {
            self.searchArray = self.subjects
        } else {
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
            let array = (self.subjects as NSArray).filteredArrayUsingPredicate(searchPredicate)
            self.searchArray = array as! [String]
        }
    }
}
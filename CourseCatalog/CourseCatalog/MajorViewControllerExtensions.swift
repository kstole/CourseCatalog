//
//  MajorViewControllerExtensions.swift
//  SearchController
//
//  Created by Stuart Breckenridge on 17/8/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import Foundation
import UIKit

extension MajorViewController: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.courseSearchController.active) {
            return self.searchArray.count
        } else {
            return self.courses.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.courseTable.dequeueReusableCellWithIdentifier("MajorCell") as! CourseTableViewCell
        let source = (self.courseSearchController.active ? self.searchArray : self.courses)
        cell.courseNum?.text = source[indexPath.row].number
        cell.courseName?.text = source[indexPath.row].name
        return cell
    }
    
}

extension MajorViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("MajorToCourse", sender: indexPath)
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
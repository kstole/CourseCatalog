//
//  CombinedViewControllerExtensions.swift
//  SearchController
//
//  Created by Kyler Stole on 17/8/14.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation
import UIKit

extension CombinedViewController: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.combinedSearchController.active) {
            return self.searchArray.count
        } else {
            return self.majors.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        let source = (self.combinedSearchController.active ? self.searchArray : self.majors)
        
        cell.textLabel?.text! = source[indexPath.row].name
        
        return cell
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
            //let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
            //let array = (self.majors as NSArray).filteredArrayUsingPredicate(searchPredicate)
            //self.searchArray = array as! [String]
            self.searchArray = self.majors.filter {
                ($0.name.lowercaseString as NSString).containsString(searchController.searchBar.text.lowercaseString) ||
                ($0.abbr.lowercaseString as NSString).containsString(searchController.searchBar.text.lowercaseString)
            }
            
        }
    }
}
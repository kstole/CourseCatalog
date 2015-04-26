//
//  InfoTableViewController.swift
//  CourseCatalog
//
//  Created by Gungor Basa on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation
import UIKit

class InfoTableViewController:UITableViewController {
    @IBOutlet weak var course_name: UILabel!
    @IBOutlet weak var course_description: UILabel!
    @IBOutlet weak var course_time: UILabel!
    @IBOutlet weak var prof_name: UILabel!
    @IBOutlet weak var prov_avg_rtg: UILabel!
    @IBOutlet weak var prof_helpful: UILabel!
    @IBOutlet weak var prof_easy: UILabel!
    @IBOutlet weak var prof_clarity: UILabel!
    
    @IBOutlet weak var course_description_cell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Class ID"
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.course_name.text = "CS517 asdf sdf sd fsd fsad fjjhhbhj j bjhhhj"
        self.course_description.text = "Lorem ipsum si dore asdfkjsd sdflknsd fsdlfk nsdlkfj sad"
        self.course_time.text = "MTH 13:00 - 15:00 sdf sdjflks dkfj sdlkfj klsadjf lsd"
        
        self.course_name.sizeToFit()
        self.course_description.sizeToFit()
        self.course_time.sizeToFit()
        
        self.tableView.reloadData()
        
    }

    
    
}

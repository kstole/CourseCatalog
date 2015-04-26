//
//  CourseViewController.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import UIKit

class CourseViewController: UITableViewController {
    
    @IBOutlet weak var course_name: UILabel!
    @IBOutlet weak var course_description: UILabel!
    @IBOutlet weak var course_time: UILabel!
    @IBOutlet weak var prof_name: UILabel!
    @IBOutlet weak var prov_avg_rtg: UILabel!
    @IBOutlet weak var prof_helpful: UILabel!
    @IBOutlet weak var prof_easy: UILabel!
    @IBOutlet weak var prof_clarity: UILabel!
    
    @IBOutlet weak var course_description_cell: UITableViewCell!

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
            self.navigationItem.title = detail.description
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


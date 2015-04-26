//
//  FirstLaunchViewController.swift
//  CourseCatalog
//
//  Created by Rutger Farry on 4/26/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import UIKit
import pop

class FirstLaunchViewController: UIViewController {

    @IBOutlet var beaverIcon: UIImageView!
    @IBOutlet var mapIcon: UIImageView!
    @IBOutlet var personIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        var beaverAnimation = POPSpringAnimation(propertyNamed:kPOPViewAlpha)
        beaverAnimation.toValue = 1.0
        beaverAnimation.springSpeed = 1.0
        
        var mapAnimation = POPSpringAnimation(propertyNamed:kPOPViewAlpha)
        mapAnimation.toValue = 1.0
        mapAnimation.springSpeed = 1.0

        
        var personAnimation = POPSpringAnimation(propertyNamed:kPOPViewAlpha)
        personAnimation.toValue = 1.0
        personAnimation.springSpeed = 1.0
        
        self.beaverIcon.pop_addAnimation(beaverAnimation, forKey: "beaverAlpha")

        delay(0.1, closure: { () -> () in
            self.mapIcon.pop_addAnimation(mapAnimation, forKey: "mapAlpha")
        })
        delay(0.3, closure: { () -> () in
            self.personIcon.pop_addAnimation(personAnimation, forKey: "personAlpha")
        })
    }

    @IBAction func getStartedButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

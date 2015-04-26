//
//  CourseViewController.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class CourseViewController: UITableViewController, CLLocationManagerDelegate, UIContentContainer  {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var profNameLabel: UILabel!
    @IBOutlet weak var profAvgRatingLabel: UILabel!
    @IBOutlet weak var profHelpfulLabel: UILabel!
    @IBOutlet weak var profEasyLabel: UILabel!
    @IBOutlet weak var profClarityLabel: UILabel!
    
    @IBOutlet weak var map: UIView!
    //var mapView : GMSMapView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var course_description_cell: UITableViewCell!

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var mapButton : UIButton!
    var detailItem: AnyObject? {
        didSet {self.configureView()}
    }
    
    var result:JSON!
    
    var dstLat:Double!
    var dstLon:Double!
    
    var userLat:Double!
    var userLon:Double!

    let locationManager = CLLocationManager()
    
    func configureView() {
        // Update the user interface for the detail item.
        if let course: Course = self.detailItem as? Course, major = course.major {
            self.navigationItem.title = "\(major.abbr) \(course.number)"
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

            //self.course_name.text = course.name
            
            NetworkManager.getClassDetailsWithId(course.id) { (json) -> Void in
                println(json)
                
                self.nameLabel.text = json["class_name"].stringValue
                
                self.timeLabel.text = json["days_of_week"].stringValue + " " + json["start_time"].stringValue + "-" + json["end_time"].stringValue
                
                self.profNameLabel.text = json["professor"]["first_name"].stringValue + " " + json["professor"]["last_name"].stringValue
                
                self.profAvgRatingLabel.text = json["professor"]["rating"].stringValue
                
                self.descriptionLabel.text = json["description"].stringValue
                self.dstLat = (json["lat"].stringValue as NSString).doubleValue
                self.dstLon = (json["lon"].stringValue as NSString).doubleValue
                self.initializeMaps(self.dstLat, lon: self.dstLon)
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // FIXME: deletes all NSUserDefaults
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        

        
        self.configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let course = detailItem as? Course where (ClassList.isAdded(course.id)) {
            self.addButton.enabled = false
        } else {
            self.addButton.enabled = true
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        getUserLocation()
        self.nameLabel.sizeToFit()
        self.descriptionLabel.sizeToFit()
        self.timeLabel.sizeToFit()
        self.profAvgRatingLabel.sizeToFit()
        
        //initializeMaps(lat, lon: lon)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeMaps(lat:Double, lon:Double) {
        var camera = GMSCameraPosition.cameraWithLatitude(lat,longitude:lon, zoom:16)
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        
        var marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = "Your Destination"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        //self.map.addSubview(mapView)
        mapView.trafficEnabled = true
        mapView.userInteractionEnabled = false
        
        mapButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        mapButton.addTarget(self, action: "goToMaps:", forControlEvents: UIControlEvents.TouchUpInside)
        mapView.frame = self.map.bounds
        mapButton.frame = mapView.bounds
        self.map.addSubview(mapView)
        self.map.addSubview(mapButton)
    }

    func goToMaps(sender: UIButton!) {
        println("Here")
        var urlString1 : String = "comgooglemaps://?saddr=" + String(stringInterpolationSegment: self.userLat) + "," + String(stringInterpolationSegment: self.userLon)
        var urlString2 : String = "&zoom=14&daddr=" + String(stringInterpolationSegment: self.dstLat) + "," + String(stringInterpolationSegment: self.dstLon)
        var urlString :String = urlString1 + urlString2  + "&directionsmode=transit"
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:urlString)!)
            println("GO To Google Maps")
        }
    }
    
    func getUserLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        
        self.userLat = locValue.latitude
        self.userLon = locValue.longitude
        locationManager.stopUpdatingLocation()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        println("size-transition")
        if let mapView = self.map.subviews[0] as? GMSMapView {
            println("subview bounds change")
            mapView.frame = self.map.bounds
        }
    }

    @IBAction func addClass(sender: AnyObject) {
        if (self.result != nil) {
            if let course = self.detailItem as? Course {
                ClassList.saveClass(course.id, json: self.result)
            }
            self.addButton.enabled = false
        }
        else {
            self.addButton.enabled = true
        }
    }
}


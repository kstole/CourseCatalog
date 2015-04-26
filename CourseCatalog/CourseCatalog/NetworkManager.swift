//
//  NetworkManager.swift
//  CourseCatalog
//
//  Created by Rutger Farry on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let url = "http://54.213.102.221:80"
    
    class func getMajors(callback:(JSON) -> Void) -> Void {
        let monitor = UIApplication.sharedApplication().networkActivityIndicatorVisible
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET, "\(url)/majors/")
            .responseJSON { (_, _, response, error) in
                    if error == nil {
                        var json = JSON(response!)
                        callback(json)
                    } else {
                        println(error)
                    }
                if !monitor {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            }
    }

    class func getClassesWithMajorId(majorId: String, term: String, callback:(JSON) -> Void) {
        let monitor = UIApplication.sharedApplication().networkActivityIndicatorVisible
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET, "\(url)/classes/", parameters: ["major_id": majorId, "term": term])
            .responseJSON { (_, _, response, error) in
                if error == nil {
                    var json = JSON(response!)
                    callback(json)
                } else {
                    println(error)
                }
                if !monitor {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            }
    }
    
    class func getClassDetailsWithId(id: String, callback:(JSON) -> Void) {
        let monitor = UIApplication.sharedApplication().networkActivityIndicatorVisible
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET, "\(url)/class_details/", parameters: ["class_id": id])
            .responseJSON { (_, _, response, error) in
                if error == nil {
                    var json = JSON(response!)
                    callback(json)
                } else {
                    println(error)
                }
                if !monitor {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            }
    }
    
    class func getClassDetailsWithCRN(crn: String, callback:(JSON) -> Void) {
        let monitor = UIApplication.sharedApplication().networkActivityIndicatorVisible
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET, "\(url)/class_details/", parameters: ["class_crn": crn])
            .responseJSON { (_, _, response, error) in
                if error == nil {
                    var json = JSON(response!)
                    callback(json)
                } else {
                    println(error)
                }
                if !monitor {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            }
    }

}

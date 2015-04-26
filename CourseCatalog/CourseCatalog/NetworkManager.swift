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
        Alamofire.request(.GET, "\(url)/majors/")
                 .responseJSON { (_, _, response, _) in
                    var json = JSON(response!)
                    callback(json)
                 }
    }
}

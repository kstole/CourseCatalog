//
//  ClassList.swift
//  CourseCatalog
//
//  Created by Gungor Basa on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation
import SwiftyJSON

class ClassList {
    class func saveClass(id:String, json:JSON) {
        var arr : NSArray = [json["class_name"].stringValue, json["description"].stringValue, json["days_of_week"].stringValue, json["start_time"].stringValue, json["end_time"].stringValue, json["professor"]["first_name"].stringValue, json["professor"]["last_name"].stringValue, json["professor"]["rating"].stringValue, (json["lat"].stringValue as NSString), (json["lon"].stringValue as NSString)]
        NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "cl" + id)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func loadClassList() -> NSArray {
        var arr : NSArray = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys.array
        var resulArr = [NSArray]()
        var i : Int
        for index in 0 ... arr.count {
            if (arr[index].hasPrefix("cl")) {
                //resulArr.append(NSUserDefaults.standardUserDefaults().objectForKey(arr[index]) as! NSArray)
            }
        }
        return NSUserDefaults.standardUserDefaults().dictionaryRepresentation().values.array
    }
    
    class func isAdded(id:String) -> Bool {
        if (NSUserDefaults.standardUserDefaults().stringForKey(id as String) == nil) {
            return false
        }
        return true
    }
}




//
//  JSONClass.swift
//  CourseCatalog
//
//  Created by Gungor Basa on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation

func getJSON(data : NSData) -> AnyObject {
    var jsonErrorOptional: NSError?
    let json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &jsonErrorOptional)
    return json
}
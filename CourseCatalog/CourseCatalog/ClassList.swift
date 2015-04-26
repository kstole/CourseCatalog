//
//  ClassList.swift
//  CourseCatalog
//
//  Created by Gungor Basa on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation

func saveClass(id:String, json:NSDictionary) {
    NSUserDefaults.standardUserDefaults().setObject(json, forKey: id)
}

func loadClassList() -> NSArray {
    return NSUserDefaults.standardUserDefaults().dictionaryRepresentation().values.array
}
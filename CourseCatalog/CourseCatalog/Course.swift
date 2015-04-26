//
//  Course.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation

class Course {
    var number: String = ""
    var name: String = ""
    var major: Major?
    
    var profRating: Float?
    
    var OSUBookPrice: Float?
    
    init(_ number: String, _ name: String) {
        self.number = number
        self.name = name
    }
}
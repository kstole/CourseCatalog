//
//  Major.swift
//  CourseCatalog
//
//  Created by Kyler Stole on 4/25/15.
//  Copyright (c) 2015 Kyler Stole. All rights reserved.
//

import Foundation

class Major {
    var name: String = "Unknown Major"
    var department: String?
    
    init(_ name: String) {
        self.name = name
    }
}
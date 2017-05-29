//
//  FilterItem.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 28/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation


struct FilterItem {
    
    var fiter: String?
    var name: String?
}


extension FilterItem {
    
    init(dict: [String:  AnyObject]) {
        self.name  = dict["name"] as? String
        self.fiter = dict["filter"] as? String
    }
}

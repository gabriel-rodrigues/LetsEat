//
//  ExploreItem.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation


struct ExploreItem {
    
    var name: String?
    var image: String?
    
}

extension ExploreItem {
    
    init(dict: [String: AnyObject]) {
        
        self.name  = dict["name"] as? String
        self.image = dict["image"] as? String
    }
    
}

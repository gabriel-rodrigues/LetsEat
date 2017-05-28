//
//  RestaurantItem.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 24/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation


struct RestaurantItem {
    
    var name: String?
    var city: String?
    var address: String?
    var price: Int?
    var state: String?
    var longitude: Float?
    var latitude: Float?
    var cuisines: [String] = []
    var image: String?
    var restaurantId: Int?
    var data: [String: AnyObject]?
    
    var cuisine: String? {
        if cuisines.isEmpty {
            return ""
        }
        
        else if cuisines.count == 1 {
            return cuisines.first
        }
        else {
            return cuisines.joined(separator: ", ")
        }
        
    }
    
    var annotation: RestaurantAnnotation {
        
        guard let restaurantData = data else {
            return RestaurantAnnotation(dicionario: [:])
        }
        
        return RestaurantAnnotation(dicionario: restaurantData)
    }
    
}


extension RestaurantItem {
    
    init (dict: [String:AnyObject]) {
        
        name         = dict["name"] as? String
        city         = dict["city"] as? String
        address      = dict["address"] as? String
        price        = dict["price"] as? Int
        longitude    = dict["lng"] as? Float
        latitude     = dict["lat"] as? Float
        restaurantId = dict["id"] as? Int
        
        if let cuisines = dict["cuisines"] as? [AnyObject] {
            for data in cuisines {
                if let cuisine = data["cuisine"] as? String {
                    self.cuisines.append(cuisine)
                }
            }
        }
        
        image = dict["image"] as? String
        data  = dict
    }
}

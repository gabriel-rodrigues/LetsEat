//
//  RestaurantItem.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 24/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation


public struct RestaurantItem {
    
    public var name: String?
    public var city: String?
    public var address: String?
    public var price: Int?
    public var state: String?
    public var longitude: Float?
    public var latitude: Float?
    public var cuisines: [String] = []
    public var image: String?
    public var restaurantId: Int?
    public var data: [String: AnyObject]?
    
    public var cuisine: String? {
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
    
    public var annotation: RestaurantAnnotation {
        
        guard let restaurantData = data else {
            return RestaurantAnnotation(dicionario: [:])
        }
        
        return RestaurantAnnotation(dicionario: restaurantData)
    }
    
}


extension RestaurantItem {
    
    public init (dict: [String:AnyObject]) {
        
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

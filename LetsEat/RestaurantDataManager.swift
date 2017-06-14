//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 27/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation


public class RestaurantDataManager {
    
    private var items: [RestaurantItem] = []
    
    
    public func fetch (by location: String, withFilter: String = "All", completationHandler: () -> Void) {
        
        var restaurants: [RestaurantItem] = []
        
        for restaurant in RestaurantAPIManager.loadJSON(file: location) {
            restaurants.append(RestaurantItem(dict: restaurant))
        }
        
        if withFilter != "All" {
            items = restaurants.filter({ (item) -> Bool in
                item.cuisines.contains(withFilter)
            })
        }
        else {
            items = restaurants
        }
        
    
        completationHandler()
        
    }
    
    public func numberOfItems() -> Int {
        
        return items.count
    }
    
    public func restaurantItem(at index: IndexPath) -> RestaurantItem {
        
        return items[index.item]
    }
    
    public init () {
        
    }
}

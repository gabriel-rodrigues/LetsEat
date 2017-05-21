//
//  LocationDataManager.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation


class LocationDataManager {
    
    private var locations: [String] = []
    
    
    func fetch() {
        
        for location in loadData() {
            locations.append(location)
        }
    }
    
    func numberOfItems() -> Int {
        return locations.count
    }
    
    func locationItem(at index: IndexPath) -> String {
        return locations[index.item]
    }
    
    private func loadData() -> [String] {
        
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "plist"), let items = NSArray(contentsOfFile: path) else {
            return []
        }
        
        return items as! [String]
    }
}

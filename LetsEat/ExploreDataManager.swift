
//
//  File.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit


class ExploreDataManager {
    
    fileprivate var items:[ExploreItem] = []
    
    func fetch() {
        
        for data in loadData() {
            items.append(ExploreItem(dict: data))
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func explore(at index: IndexPath) -> ExploreItem {
        return items[index.item]
    }
    
    
    fileprivate func loadData() -> [[String: AnyObject]] {
        
        guard let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"), let items = NSArray(contentsOfFile: path)  else {
            return [[:]]
        }
        
        return items as! [[String: AnyObject]]
        
    }
}

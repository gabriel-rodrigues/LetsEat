//
//  FilterManager.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 28/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation


class FilterManager: DataManagerProtocol {
    
    private var items: [FilterItem] = []
    
    let fileName = "FilterData"
    
    func fetch() {
        
        for data in self.load() {
            self.items.append(FilterItem(dict: data))
        }
    }
    
    func numberOfItems() -> Int {
        
        return self.items.count
    }
    
    func filterItemAtIndex(at index:IndexPath) -> FilterItem {
        
        return self.items[index.item]
    }
}

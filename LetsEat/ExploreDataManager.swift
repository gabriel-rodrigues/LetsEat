
//
//  File.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit


class ExploreDataManager : DataManagerProtocol {
    
    fileprivate var items:[ExploreItem] = []
    
    let fileName: String = "ExploreData"
    
    
    func fetch() {
        
        for data in self.load() {
            items.append(ExploreItem(dict: data))
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func explore(at index: IndexPath) -> ExploreItem {
        return items[index.item]
    }

}

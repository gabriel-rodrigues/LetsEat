//
//  ReviewDataManager.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 29/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class ReviewDataManager: NSObject {

    private var items: [ReviewItem] = []
    
    let manager = CoreDataManager()
    
    
    func fetchReview(by id: Int) {
        
        if self.items.count > 0 {
            self.items.removeAll()
        }
        
        for data in self.manager.fetchReviews(by: id) {
            items.append(data)
        }
    }
    
    
    func numberOfItems() -> Int {
        
        return self.items.count
    }
    
    func reviewItem(at index: IndexPath) -> ReviewItem {
        
        return self.items[index.item]
    }
    
    
    func getLatestReview() -> ReviewItem {
        
        guard let item = self.items.first else {
            return ReviewItem()
        }
        
        return item
    }
}

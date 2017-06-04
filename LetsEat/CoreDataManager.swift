//
//  CoreDataManager.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 29/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    
    let container: NSPersistentContainer
    
    override init() {
        
        self.container = NSPersistentContainer(name: "LetsEatModel")
        self.container.loadPersistentStores { (description, error) in
            
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
        
        super.init()
    }
    
    fileprivate func save() {
        
        do {
            if self.container.viewContext.hasChanges {
                try self.container.viewContext.save()
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addReview(_ item: ReviewItem) {
        
        let review = Review(context: self.container.viewContext)
        review.name = item.name
        review.date = NSDate()
        
        if let rating = item.rating {
            review.rating = rating
        }
        
        review.customerReview = item.customerReview
        review.photo          = item.photoData
        review.uuid           = item.uuid
        
        if let id = item.restaurantID {
            review.restaurantID = Int32(id)
            
            print("restaurant id \(id)")
            save()
        }
    }
    
    
    func fetchReviews(by identifier: Int) -> [ReviewItem] {
        
        let moc = self.container.viewContext
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(identifier))
        
        var items: [ReviewItem] = []
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        do {
            for data in try moc.fetch(request) {
                items.append(ReviewItem(data: data))
            }
            
            return items
        }
        catch {
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
}

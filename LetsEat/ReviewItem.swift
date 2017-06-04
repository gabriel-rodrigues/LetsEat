//
//  ReviewItem.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 29/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit


struct ReviewItem {
    
    var rating: Float?
    var photo: UIImage?
    var name: String?
    var customerReview: String?
    var date: NSDate?
    var restaurantID: Int?
    var uuid = UUID().uuidString
    
    
    var photoData: NSData {
        
        guard let image = photo else {
            return NSData()
        }
        
        return NSData(data: UIImagePNGRepresentation(image)!)
    }
    
    
    var displayDate: String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        return formatter.string(from: self.date! as Date)
    }
}


extension ReviewItem {
    
    init(data: Review) {
        
        self.date = data.date
        self.customerReview = data.customerReview
        self.name           = data.name
        self.restaurantID   = Int(data.restaurantID)
        
        if let photo = data.photo {
            self.photo = UIImage(data: photo as Data, scale: 1.0)
        }
        else {
            self.photo = #imageLiteral(resourceName: "restaurant-list-img")
        }
        
        self.rating = data.rating
        
        if let uuid = data.uuid {
            self.uuid = uuid
        }
    }
}

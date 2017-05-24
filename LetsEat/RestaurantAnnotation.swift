//
//  RestaurantAnnotation.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 23/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit
import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {

    var name: String?
    var cuisines: [String] = []
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var postalCode:String?
    var state:String?
    var imagemURL: String?
    var data: [String: AnyObject]?
    
    
    init(dicionario: [String: AnyObject]) {
        
        if let lat = dicionario["lat"] as? Double {
            self.latitude = lat
        }
        
        if let long = dicionario["lng"] as? Double {
            self.longitude = long
        }
        
        if let name = dicionario["name"] as? String {
            self.name = name
        }
        
        if let cuisines = dicionario["cuisines"] as? [String] {
            self.cuisines = cuisines
        }
        
        if let address = dicionario["address"] as? String {
            self.address = address
        }
        
        if let postalCode = dicionario["postal_code"] as? String {
            self.postalCode = postalCode
        }
        
        if let state = dicionario["state"] as? String {
            self.state = state
        }
        
        if let image = dicionario["image_url"] as? String {
            self.imagemURL = image
        }
        
        self.data = dicionario
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        
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
    
    var coordinate: CLLocationCoordinate2D {
        
        guard let lat = latitude, let long = longitude else {
            return CLLocationCoordinate2D()
        }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var restautantItem: RestaurantItem {
        
        guard let restaurantData = self.data else {
            return RestaurantItem()
        }
        
        return RestaurantItem(dict: restaurantData)
    }
}

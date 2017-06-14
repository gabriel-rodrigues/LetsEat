//
//  RestaurantAnnotation.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 23/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit
import MapKit

public class RestaurantAnnotation: NSObject, MKAnnotation {

    public var name: String?
    public var cuisines: [String] = []
    public var latitude: Double?
    public var longitude: Double?
    public var address: String?
    public var postalCode:String?
    public var state:String?
    public var imagemURL: String?
    public var data: [String: AnyObject]?
    
    
    public init(dicionario: [String: AnyObject]) {
        
        if let lat = dicionario["lat"] as? Double {
            self.latitude = lat
        }
        
        if let long = dicionario["lng"] as? Double {
            self.longitude = long
        }
        
        if let name = dicionario["name"] as? String {
            self.name = name
        }
        
        if let cuisines = dicionario["cuisines"] as? [AnyObject] {
            for data in cuisines {
                if let cuisine = data["cuisine"] as? String {
                    self.cuisines.append(cuisine)
                }
            }
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
    
    public var title: String? {
        return name
    }
    
    public var subtitle: String? {
        
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
    
    public var coordinate: CLLocationCoordinate2D {
        
        guard let lat = latitude, let long = longitude else {
            return CLLocationCoordinate2D()
        }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    public var restautantItem: RestaurantItem {
        
        guard let restaurantData = self.data else {
            return RestaurantItem()
        }
        
        return RestaurantItem(dict: restaurantData)
    }
}

//
//  RestaurantAPIManager.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 24/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation


struct RestaurantAPIManager {
    
    static func loadJSON(file name: String) -> [[String: AnyObject]] {
        
        var items = [[String: AnyObject]]()
        
        guard let path = Bundle.main.path(forResource: name, ofType: "json"), let data = NSData(contentsOfFile: path) else {
            return [[:]]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as AnyObject
            
            if let restaurants = json["restaurants"] as? [[String: AnyObject]] {
                items = restaurants as [[String: AnyObject]]
            }
        }
        catch {
            print("Error serializing JSON: \(error)")
            items = [[:]]
        }
        
        return items
    }
}

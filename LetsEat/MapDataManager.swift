//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 23/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation
import MapKit


class MapDataManager : DataManagerProtocol {
    
    fileprivate var items: [RestaurantAnnotation] = []
    
    var annotations: [RestaurantAnnotation] {
        return items
    }
    
    let fileName: String = "MapLocations"
    
    func fetch(completation: (_ annotations: [RestaurantAnnotation]) -> Void) {
        
        if self.items.count > 0  {
            self.items.removeAll()
        }
        
        for data in self.load() {
            self.items.append(RestaurantAnnotation(dicionario: data))
        }
        
        completation(self.items)
    }
    
    func currentRegion(latitudeDelta latitude: CLLocationDegrees, longitudeDelta longitude: CLLocationDegrees) -> MKCoordinateRegion {
        
        guard let item = self.items.first else {
            return MKCoordinateRegion()
        }
        
        let span = MKCoordinateSpan(latitudeDelta: latitude,
                                    longitudeDelta: longitude)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
 }

//
//  RestaurantDetailTableViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 24/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailTableViewController: UITableViewController {

    @IBOutlet var nomeLabel: UILabel!
    @IBOutlet var cuisineLabel:UILabel!
    @IBOutlet var headerAddressLabel:UILabel!
    @IBOutlet var tableDetailsLabel:UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var reviewsContainer: UIView!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var txtReview: UITextView!
    @IBOutlet var imgRating: UIImageView!
    @IBOutlet var btnHeart: UIBarButtonItem!
    @IBOutlet var noReviewsContainer: UIView!
    
    var selectedRestaurant: RestaurantItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    func initialize() {
        self.setupLabels()
        self.setupMap()
    }
    
    func setupMap() {
        
        guard let annotation = self.selectedRestaurant?.annotation, let long = annotation.longitude, let lat = annotation.latitude else {
            return
        }
        
        
        let location = CLLocationCoordinate2D(latitude: lat,
                                              longitude: long)
        
        let span   = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: location,
                                        span: span)
        
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(annotation)
    }
    
    func setupLabels() {
        
        guard  let restaurant = self.selectedRestaurant else {
            return
        }
        
        if let name = restaurant.name {
            self.nomeLabel.text = name
        }
        
        if let cuisine = restaurant.cuisine {
            self.cuisineLabel.text = cuisine
        }
        
        if let address = restaurant.address {
            self.addressLabel.text       = address
            self.headerAddressLabel.text = address
        }
    
        
        self.tableDetailsLabel.text = "Table for 7, tonight at 10:00PM"
    }
}


//
//  RestaurantDetailTableViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 24/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit
import MapKit
import LetsEatDataKit

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
    let manager = ReviewDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkReviews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showReview.rawValue:
                self.showReview(segue: segue)
            case Segue.showAllReviews.rawValue:
                self.showAllReviews(segue: segue)
            default:
                print("Segue not added")
            }
        }
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
    
    func showReview(segue: UIStoryboardSegue) {
        
        if let viewController = segue.destination as? CreateReviewTableViewController {
            viewController.selectedRestaurantID = selectedRestaurant?.restaurantId
        }
    }
    
    func showAllReviews(segue: UIStoryboardSegue) {
        
        if let viewController = segue.destination as? ReviewListViewController {
            viewController.selectedRestaurantId = selectedRestaurant?.restaurantId
        }
    }
    
    func checkReviews() {
        
        if let id = selectedRestaurant?.restaurantId {
            manager.fetchReview(by: id)
        }
        
        let count = manager.numberOfItems()
        
        if count > 0 {
            noReviewsContainer.isHidden = true
        }
        
        let item = manager.getLatestReview()
        userLabel.text = item.name
        txtReview.text = item.customerReview
        
        if let rating = item.rating {
            imgRating.image = UIImage(named: Rating.image(rating: rating))
        }
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


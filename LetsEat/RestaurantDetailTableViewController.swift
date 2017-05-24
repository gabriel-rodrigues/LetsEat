//
//  RestaurantDetailTableViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 24/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewController: UITableViewController {

    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.selectedRestaurant as Any)
    }
}

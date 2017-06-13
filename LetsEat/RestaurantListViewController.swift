//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!

    var selectedRestaurant: RestaurantItem?
    var selectedCity: String?
    var selectedType: String?
    
    let manager = RestaurantDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        guard let location = self.selectedCity, let type = self.selectedType else {
            return
        }
        
        self.manager.fetch(by: location, withFilter: type) { 
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showDetail.rawValue:
                self.showRestaurantDetail(segue: segue)
            default:
                print("Segue not added")
            }
        }
    }
    
    func initialize() {
        
        if Device.isPad {
            setupCollectionView()
        }
    }
    
    
    func setupCollectionView() {
        
        let flow = UICollectionViewFlowLayout()
        
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        
        self.collectionView?.collectionViewLayout = flow
    }
    
    
    func showRestaurantDetail(segue: UIStoryboardSegue) {
        
        if let viewController = segue.destination as? RestaurantDetailTableViewController, let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
            self.selectedRestaurant           = manager.restaurantItem(at: indexPath)
            viewController.selectedRestaurant = selectedRestaurant
        }
     }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        self.collectionView.reloadData()
    }
}

extension RestaurantListViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if Device.isPhone {
            let cellWidth = collectionView.frame.size.width
            
            return CGSize(width: cellWidth, height: 135)
        }
        
        else {
            
            let screenRect  = collectionView.frame.size.width
            let screenWidth = screenRect - 21
            let cellWidth   = screenWidth / 2.0
            
            return CGSize(width: cellWidth, height: 135)
        }
    }
}

extension RestaurantListViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.manager.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCollectionViewCell
        let item = self.manager.restaurantItem(at: indexPath)
        
        if let name = item.name {
            cell.titleLabel.text = name
        }
        
        if let city = item.city {
            cell.cityLabel.text = city
        }
        
        if let cuisine = item.cuisine {
            cell.cuisineLabel.text = cuisine
        }
        
        return cell
    }
}

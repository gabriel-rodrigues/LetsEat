//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    let manage = ExploreDataManager()
    
    var selectedCity: String?
    
    fileprivate let minItemSpacing: CGFloat = 7

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initilize()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case Segue.locationList.rawValue:
            self.showLocationList(segue: segue)
        case Segue.restaurantList.rawValue:
            self.showRestaurantListing(segue: segue)
        default:
            print("Segue not added")
        }
    }
    
    func initilize() {
        
        manage.fetch()
        
        if Device.isPad {
            setupCollectionView()
        }
    }
    
    func setupCollectionView() {
        
        let flow = UICollectionViewFlowLayout()
        
        flow.sectionInset            = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing      = 7
        
        self.collectionView?.collectionViewLayout = flow
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == Segue.restaurantList.rawValue {
            guard selectedCity != nil else {
                self.showAlert()
                return false
            }
            
            return true
        }
        
        return true
    }

    func showLocationList(segue: UIStoryboardSegue) {
        
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? LocationViewController else {
            return
        }
        
        guard let city = self.selectedCity else {
            return
        }
        
        viewController.selectedCity = city
    }
    
    func showRestaurantListing(segue: UIStoryboardSegue) {
        
        if let viewController = segue.destination as? RestaurantListViewController, let city = self.selectedCity,
            let index = collectionView.indexPathsForSelectedItems?.first, let type = manage.explore(at: index).name {
            
            viewController.selectedType = type
            viewController.selectedCity = city
        }
    }
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Location Needed",
                                                message: "Please select a location.",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        self.collectionView.reloadData()
    }
    
    
    @IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindLocationDone(segue: UIStoryboardSegue) {
        
        if let viewController = segue.source as? LocationViewController {
            self.selectedCity = viewController.selectedCity
            
            if let location = selectedCity {
                self.locationLabel.text = location
            }
        }
    }
}


extension ExploreViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if Device.isPad {
            
            let factor = traitCollection.horizontalSizeClass == .compact ? 2 : 3
            
            let screenRect  = collectionView.frame.size.width
            let screenWidth = screenRect - (CGFloat(minItemSpacing) * CGFloat(factor + 1))
            let cellwidth   = screenWidth / CGFloat(factor)
            
            return CGSize(width: cellwidth, height: 154)
        }
        
        else {
            
            let screenRect  = collectionView.frame.size.width
            let screenWidth = screenRect - 21
            let cellWidth   = screenWidth / 2.0
            
            return CGSize(width: cellWidth, height: 154)
        }
    }
}

extension ExploreViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manage.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
        cell.setup(with: manage.explore(at: indexPath))
        
        return cell
    }
}

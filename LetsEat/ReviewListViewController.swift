//
//  ReviewListViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 03/06/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class ReviewListViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    var selectedRestaurantId: Int?
    let manager = ReviewDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialize()
    }

    func initialize() {
        
        if let id = selectedRestaurantId {
            manager.fetchReview(by: id)
            setupTableView()
        }
    }
    
    func setupTableView() {
        
        tableView.estimatedRowHeight = 128
        tableView.rowHeight          = UITableViewAutomaticDimension
        tableView.tableFooterView    = UIView()
        tableView.dataSource         = self
    }
     
}

extension ReviewListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        
        let review          = manager.reviewItem(at: indexPath)
        cell.lblUser.text   = review.name
        cell.lblReview.text = review.customerReview
        cell.lblDate.text   = review.displayDate
        
        if let rating = review.rating {
            cell.imgRating.image = UIImage(named: Rating.image(rating: rating))
        }
        
        if let photo = review.photo {
            cell.imgReview.image = photo
        }
        
        return cell
    }
}

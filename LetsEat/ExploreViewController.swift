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
    let manage = ExploreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manage.fetch()
    }

    
    @IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {
        
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

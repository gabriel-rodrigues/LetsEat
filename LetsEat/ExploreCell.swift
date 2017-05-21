//
//  ExploreCell.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    @IBOutlet var nomeLabel: UILabel!
    @IBOutlet var imgExplore: UIImageView!
    
    
    func setup(with exploreItem: ExploreItem) {
        
        nomeLabel.text = exploreItem.name!
        imgExplore.image = UIImage(named: exploreItem.image!)
    }
}

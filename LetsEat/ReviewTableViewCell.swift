//
//  ReviewTableViewCell.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 03/06/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet var imgReview: UIImageView!
    @IBOutlet var imgRating: UIImageView!
    @IBOutlet var lblUser: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

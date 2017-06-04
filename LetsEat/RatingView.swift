//
//  RatingView.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 03/06/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class RatingView: UIView {

    @IBOutlet private var contentView: UIView?
    @IBOutlet var imgRating: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, value: Rating) {
        
        super.init(frame: frame)
        
        setupDefaults()
        setup(rating: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }
    
    func setup(rating: Rating) {
        
        self.imgRating.image = UIImage(named: Rating.image(rating: rating.value))
    }
    
    private func setupDefaults() {
        
        Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)
        
        guard let content = contentView else {
            return
        }
        
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        self.addSubview(content)
    }
    
}

//
//  PhotoItem.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 28/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class PhotoItem: UIView, ImageFiltering {
    
    var imgThub: UIImageView?
    var lblTitle: UILabel?
    var data: FilterItem?
    
    weak var delegate: ImageFilteringDelete?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, image: UIImage, item: FilterItem) {
        super.init(frame: frame)
        
        self.setDefaults(item: item)
        self.createThumbnail(image: image, item: item)
        self.createLabel(item: item)
    }
    
    
    func setDefaults(item: FilterItem) {
        self.data = item
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(thumbTapped))
        self.addGestureRecognizer(tap)
        self.backgroundColor = UIColor.clear
    }
    
    func createThumbnail(image: UIImage, item: FilterItem) {
        
        guard let filterName = item.fiter else {
            return
        }
        
        if filterName != "None" {
            let filteredImage = self.apply(filter: filterName, originalImage: image)
            self.imgThub      = UIImageView(image: filteredImage)
        }
        else {
            self.imgThub = UIImageView(image: image)
        }
        
        guard let thumb = self.imgThub else {
            return
        }
        
        thumb.contentMode   = .scaleAspectFit
        thumb.frame         = CGRect(x: 0, y: 22, width: 102, height: 102)
        thumb.clipsToBounds = true
        
        addSubview(thumb)
    }
    
    func createLabel(item: FilterItem) {
        
        guard let displayName = item.name else {
            return
        }
        
        self.lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 102, height: 22))
        
        guard  let label = self.lblTitle else {
            return
        }
        
        label.text            = displayName
        label.font            = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment   = .center
        label.backgroundColor = .clear
        
        self.addSubview(label)
    }
    
    
    func thumbTapped() {
        
        if let data = self.data {
            filterSelected(item: data)
        }
    }
    
    func filterSelected(item: FilterItem) {
        
        self.delegate?.filterSelected(item: item)
    }
    
    
}

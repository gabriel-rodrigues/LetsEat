//
//  ApplyFilterViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 28/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class ApplyFilterViewController: UIViewController {

    var image: UIImage?
    var thumbnail: UIImage?
    let manager = FilterManager()
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var imgExample: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initilize()
    }
    
    func initilize() {
        
        self.manager.fetch()
        
        if let image = self.image, let thumb = self.thumbnail {
            self.createScrollContent(img: thumb)
            self.imgExample.image = image
        }
    }
    
    func createScrollContent(img: UIImage) {
        
        DispatchQueue.main.async {
            
            let size = CGFloat(102)
            var currentSizeOffSet = CGFloat(10)
            
            for index in 0..<self.manager.numberOfItems() {
                let item  = self.manager.filterItemAtIndex(at: IndexPath(item: index, section: 0))
                let frame = CGRect(x: currentSizeOffSet, y: 0, width: size, height: 124)
                let subview = PhotoItem(frame: frame, image: img, item: item)
                subview.delegate = self
                
                self.scrollView.addSubview(subview)
                currentSizeOffSet += (size + 10)
            }
            
            self.scrollView.showsVerticalScrollIndicator = false
            self.scrollView.contentSize = CGSize(width: CGFloat(self.manager.numberOfItems() * 113), height: size)
        }
    }

}

extension ApplyFilterViewController: ImageFiltering, ImageFilteringDelete {
    
    
    func filterSelected(item: FilterItem) {
        
        let filteredImg = self.image
        
        if let filterName = item.fiter, let img = filteredImg {
            if filterName != "None" {
                self.imgExample.image = self.apply(filter: filterName, originalImage: img)
            }
            else {
                self.imgExample.image = img
            }
        }
    }
    
}

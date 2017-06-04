//
//  StarRatingViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 03/06/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class StarRatingViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var selectedRating: Rating = Rating.zero
    var pickerDataSource = [
        Rating.five,
        Rating.fourHalf,
        Rating.four,
        Rating.threeHalf,
        Rating.three,
        Rating.twoHalf,
        Rating.two,
        Rating.oneHalf,
        Rating.one,
        Rating.half,
        Rating.zero]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    func initialize() {
        
        setDefaults()
    }

    
    func setDefaults() {
        
        self.pickerView.dataSource = self
        self.pickerView.delegate   = self
        
        if let index = self.pickerDataSource.index(of: self.selectedRating) {
            self.pickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }
}

extension StarRatingViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataSource.count
    }
    
}

extension StarRatingViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let frame      = CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: component).width-10, height: pickerView.rowSize(forComponent: component).height)
        let ratingView = RatingView(frame: frame, value: self.pickerDataSource[row])
        
        return ratingView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedRating = self.pickerDataSource[row]
    }
}


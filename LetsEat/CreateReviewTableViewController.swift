//
//  CreateReviewTableViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 28/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class CreateReviewTableViewController: UITableViewController {

    
    @IBOutlet var tvReview: UITextView!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var btnThumbnail: UIButton!
    @IBOutlet var btnRating: UIButton!
    
    var image:UIImage?
    var thumbnail: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case Segue.applyFilter.rawValue:
            self.showApplyFilter(with: segue)
        default:
            print("Segue not added")
        }
    }
    
    func initialize() {
        
        self.requestAccess()
        self.updateTextView()
    }
    
    func updateTextView() {
        
        self.tvReview.layer.borderColor  = UIColor.lightGray.cgColor
        self.tvReview.layer.borderWidth  = 0.5
        self.tvReview.layer.cornerRadius = 5.0
        self.tvReview.text               = ""
    }
    
    func showApplyFilter(with segue: UIStoryboardSegue) {
        
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? ApplyFilterViewController else {
            return
        }
        
        viewController.image     = image
        viewController.thumbnail = thumbnail
    }
    
    func requestAccess() {
        
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (granted) in
            if granted {}
        }
    }
    
    func checkSource() {
        
        let cameraMediaType = AVMediaTypeVideo
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .authorized:
            self.showCameraUserInterface()
        case .restricted, .denied:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: cameraMediaType, completionHandler: { (granted) in
                if granted {
                    self.showCameraUserInterface()
                }
            })
        }
    }
    
    
    @IBAction func unwindReviewCancel(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindRatingSave(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindFilterSave(segue: UIStoryboardSegue) {
        
        if let viewController = segue.source as? ApplyFilterViewController {
            if let thumbnail = viewController.imgExample?.image {
                btnThumbnail.setImage(thumbnail, for: .normal)
            }
        }
    }
    
    @IBAction func onPhotoTapped(_ sender: AnyObject) {
        self.checkSource()
    }
}

extension CreateReviewTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showCameraUserInterface() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        #if (arch(i386) || arch(x86_64) && os(iOS))
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        #else
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.showsCameraControls = true
        #endif
        
        
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func generate(image: UIImage, ratio: CGFloat) -> UIImage {
        
        let size = image.size
        var croppedSize: CGSize?
        var offsetX: CGFloat = 0.0
        var offSetY: CGFloat = 0.0
        
        if size.width > size.height {
            offsetX = (size.height - size.width) / 2
            croppedSize = CGSize(width: size.height, height: size.height)
        }
        else {
            offSetY = (size.width - size.height) / 2
            croppedSize = CGSize(width: size.width, height: size.height)
        }
        
        guard let cropped = croppedSize, let cgImage = image.cgImage else {
            return UIImage()
        }
        
        let clippedRect = CGRect(x: offsetX * -1, y: offSetY * -1, width: cropped.width, height: cropped.height)
        let imgRef      = cgImage.cropping(to: clippedRect)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: ratio, height: ratio)
        UIGraphicsBeginImageContext(rect.size)
        
        if let ref = imgRef {
            UIImage(cgImage: ref).draw(in: rect)
            
        }
        
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let thumb = thumbnail else {
            return UIImage()
        }
        
        return thumb
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        if let img = image {
            self.btnThumbnail.imageView?.image = self.generate(image: img, ratio: CGFloat(102))
            self.thumbnail = self.generate(image: img, ratio: CGFloat(102))
            self.image     = self.generate(image: img, ratio: CGFloat(752))
        }
        
        
        picker.dismiss(animated: true) { 
            self.performSegue(withIdentifier: Segue.applyFilter.rawValue, sender: self)
        }
    }
    
}

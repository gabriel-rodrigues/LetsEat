//
//  MapViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 23/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private let manager = MapDataManager()
    
    fileprivate var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case Segue.showDetail.rawValue:
            showRestaurantDetail(segue: segue)
        default:
            print("Segue not added")
        }
    }

    func initialize() {
        
        self.mapView.delegate = self
        self.manager.fetch { (annotations) in
            self.addMap(annotations)
        }
    }
    
    func addMap(_ annotations: [RestaurantAnnotation]) {
        
        self.mapView.setRegion(manager.currentRegion(latitudeDelta: 0.5, longitudeDelta: 0.5), animated: true)
        self.mapView.addAnnotations(manager.annotations)
    }
    
    func showRestaurantDetail(segue: UIStoryboardSegue) {
        
        if let viewController = segue.destination as? RestaurantDetailTableViewController, let restaurant = self.selectedRestaurant {
            viewController.selectedRestaurant = restaurant
        }
    }
    
    
}


extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = mapView.selectedAnnotations.first else {
            return
        }
        
        let data = annotation as! RestaurantAnnotation
        
        self.selectedRestaurant = data.restautantItem
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "custompin"
        
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        var annotationView: MKAnnotationView?
        
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image          = UIImage(named: "custom-annotation")
        }
        
        return annotationView
    }

    
}

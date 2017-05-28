//
//  LocationViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let manager = LocationDataManager()
    
    var selectedCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.fetch()
    }
    
    
    func set(selected cell: UITableViewCell, at indexPath: IndexPath) {
        
        if let city = self.selectedCity {
            let data = manager.findLocation(by: city)
            
            if data.isFound {
                if indexPath.row == data.position {
                    cell.accessoryType = .checkmark
                }
                else {
                    cell.accessoryType = .none
                }
            }
        }
        else {
            cell.accessoryType = .none
        }
    }
}


extension LocationViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell             = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = manager.locationItem(at: indexPath)
        
        self.set(selected: cell, at: indexPath)
        
        return cell
    }
}

extension LocationViewController : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            self.selectedCity  = manager.locationItem(at: indexPath)
            
            self.tableView.reloadData()
        }
        
    }
}

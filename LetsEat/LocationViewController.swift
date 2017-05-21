//
//  LocationViewController.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 20/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    let manager = LocationDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.fetch()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell             = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = manager.locationItem(at: indexPath)
        
        return cell
    }
    
}

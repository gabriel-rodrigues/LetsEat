//
//  DataManagerProtocol.swift
//  LetsEat
//
//  Created by Gabriel Rodrigues on 23/05/17.
//  Copyright © 2017 Apê Software. All rights reserved.
//

import Foundation

internal protocol DataManagerProtocol {
    
    var fileName: String { get }
}

extension DataManagerProtocol {
    
    func load() -> [[String: AnyObject]] {
        
        guard let path = Bundle.main.path(forResource: self.fileName, ofType: "plist"), let items = NSArray(contentsOfFile: path) else {
            return [[:]]
        }
        
        return items as! [[String: AnyObject]]
    }
    
}

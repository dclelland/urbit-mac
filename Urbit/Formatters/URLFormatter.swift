//
//  URLFormatter.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

class URLFormatter: Formatter {
    
    enum Mode {
        
        case abbreviating
        case expanding
        
    }
    
    var directory: Bool = false
    
    var mode: Mode = .abbreviating
    
    convenience init(directory: Bool = false, mode: Mode = .abbreviating) {
        self.init()
        self.directory = directory
        self.mode = mode
    }
    
    override func string(for object: Any?) -> String? {
        switch mode {
        case .abbreviating:
            return (object as? URL)?.abbreviatedPath
        case .expanding:
            return (object as? URL)?.expandedPath
        }
    }
    
    override func getObjectValue(_ object: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        object?.pointee = URL(fileURLWithPath: string, isDirectory: directory) as AnyObject
        return true
    }
    
}

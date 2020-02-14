//
//  URLFormatter.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

class URLFormatter: Formatter {
    
    let directory: Bool = false
    
    override func string(for object: Any?) -> String? {
        return (object as? URL)?.path
    }
    
    override func getObjectValue(_ object: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        object?.pointee = URL(fileURLWithPath: string, isDirectory: directory) as AnyObject
        return true
    }
    
}

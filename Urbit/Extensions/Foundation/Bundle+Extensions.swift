//
//  Bundle+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 23/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

extension Bundle {
    
    var name: String {
        return object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
}

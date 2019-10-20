//
//  Bundle+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 20/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

extension Bundle {
    
    var urbitPath: String? {
        return path(forResource: "urbit", ofType: nil, inDirectory: "urbit-darwin-v0.9.0")
    }
    
}

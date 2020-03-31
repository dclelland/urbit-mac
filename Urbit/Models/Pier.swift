//
//  Pier.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation
import Defaults

extension Defaults.Keys {
    
    static let piers = Key<[Pier]>("piers", default: [])
    
}

extension Pier {
    
    static var all: [Pier] {
        get {
            return Defaults[.piers]
        }
        set {
            Defaults[.piers] = newValue
        }
    }
    
}

struct Pier: Codable {
    
    var url: URL
    
}

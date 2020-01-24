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

struct Pier: Codable, Equatable {
    
    var url: URL
    
}

extension Pier {
    
    static var all: [Pier] {
        set {
            Defaults[.piers] = newValue
        }
        get {
            return Defaults[.piers]
        }
    }
    
}

extension Pier {
    
    var name: String {
        return url.lastPathComponent
    }
    
}

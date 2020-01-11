//
//  Bundle+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 20/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

extension Bundle {
    
    var urbitExecutableURL: URL {
        return url(forAuxiliaryExecutable: "urbit")!
    }
    
    var kingExecutableURL: URL {
        return url(forAuxiliaryExecutable: "king-darwin-dynamic-06934959caa286c2778f034fca346a7b790c12e9")!
    }
    
}

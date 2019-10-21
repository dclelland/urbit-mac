//
//  Bundle+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 20/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

extension Bundle {
    
    var urbitExecutablePath: String? {
        return path(forAuxiliaryExecutable: "urbit")
    }
    
}

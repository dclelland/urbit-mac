//
//  AppConstants.swift
//  Urbit
//
//  Created by Daniel Clelland on 23/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation
import Defaults

extension URL {
    
    static let urbitBridgeURL = URL(string: "https://bridge.urbit.org/")!
    
}

extension Defaults.Keys {
    
    static let piers = Key<[URL]>("piers", default: [])
    
}

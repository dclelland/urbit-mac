//
//  URL+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 31/03/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

extension URL {
    
    var abbreviatedPath: String {
        return (path as NSString).abbreviatingWithTildeInPath
    }
    
    var expandedPath: String {
        return (path as NSString).expandingTildeInPath
    }
    
}

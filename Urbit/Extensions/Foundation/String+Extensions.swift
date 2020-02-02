//
//  String+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 3/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

extension String {
    
    var fileName: String {
        var components = self.components(separatedBy: ".")
        guard components.count > 1 else {
            return self
        }
        components.removeLast()
        return components.joined(separator: ".")
    }
    
    var fileExtension: String? {
        let components = self.components(separatedBy: ".")
        guard components.count > 1 else {
            return nil
        }
        return components.last
    }
    
}

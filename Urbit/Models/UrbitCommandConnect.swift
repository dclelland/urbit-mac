//
//  UrbitCommandConnect.swift
//  Urbit
//
//  Created by Daniel Clelland on 13/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

struct UrbitCommandConnect: UrbitCommand {
    
    var pier: URL
    
    var arguments: [String] {
        return ["con", pier.absoluteString]
    }
    
}

//
//  UrbitCommandRun.swift
//  Urbit
//
//  Created by Daniel Clelland on 13/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

struct UrbitCommandRun: UrbitCommand {
    
    var pier: URL
    var options: [UrbitCommandOption] = []
    
    var arguments: [String] {
        var arguments = ["run", pier.absoluteString]
        for option in options {
            arguments += option.arguments
        }
        return arguments
    }
    
}

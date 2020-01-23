//
//  UrbitCommandRun.swift
//  Urbit
//
//  Created by Daniel Clelland on 13/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

class UrbitCommandRun: UrbitCommand {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["run"] + arguments)
    }
    
    convenience init(pier: URL, options: [UrbitCommandOption] = []) {
        self.init(arguments: [pier.path] + options.flatMap { $0.arguments })
    }
    
}

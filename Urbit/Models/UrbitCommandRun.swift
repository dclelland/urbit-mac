//
//  UrbitCommandRun.swift
//  Urbit
//
//  Created by Daniel Clelland on 13/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

class UrbitCommandRun: UrbitCommand {
    
    override init(arguments: [String]) {
        super.init(arguments: ["run"] + arguments)
    }
    
}

extension UrbitCommandRun {
    
    convenience init(pier: URL, options: [UrbitCommandOption] = []) {
        self.init(arguments: [pier.absoluteString] + options.flatMap { $0.arguments })
    }
    
}

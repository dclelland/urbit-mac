//
//  Process+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 20/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

extension Process {
    
    convenience init(executableURL: URL, arguments: [String]) {
        self.init()
        self.executableURL = executableURL
        self.arguments = arguments
    }
    
}

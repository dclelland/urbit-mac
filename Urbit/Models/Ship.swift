//
//  Ship.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

enum Ship {
    
    case ready
    case starting
    case running(process: Process)
    case failed(process: Process, error: Error)
    
}

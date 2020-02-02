//
//  Ship.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation
import UrbitClient
import PromiseKit

enum Ship {
    
    case ready
    case creating(process: Process)
    case starting(process: Process)
    case started(process: Process)
    case stopped(process: Process, error: Error)
    
}

extension Ship {
    
    var process: Process? {
        switch self {
        case .ready:
            return nil
        case .creating(let process):
            return process
        case .starting(let process):
            return process
        case .started(let process):
            return process
        case .stopped(let process, _):
            return process
        }
    }
    
}

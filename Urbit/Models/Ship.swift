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
    case starting(process: Process)
    case started(process: Process)
    case stopped(process: Process, error: Error)
    
}

extension Ship {
    
    func start() -> Promise<Ship> {
        #warning("TODO: This")
        return Promise.value(self)
    }
    
    func stop() -> Promise<Ship> {
        #warning("TODO: This")
        return Promise.value(self)
    }
    
}

extension Ship {
    
    var process: Process? {
        switch self {
        case .ready:
            return nil
        case .starting(let process):
            return process
        case .started(let process):
            return process
        case .stopped(let process, _):
            return process
        }
    }
    
}

//
//  UrbitCommandOption.swift
//  Urbit
//
//  Created by Daniel Clelland on 13/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

enum UrbitCommandOption: CustomStringConvertible {
    
    case ames(port: UInt16)
    case quiet
    case verbose
    case exit
    case dryRun
    case trace
    case local
    case collectEffects
    case offline
    
    var description: String {
        switch self {
        case .ames(let port):
            return "--ames \(port)"
        case .quiet:
            return "--quiet"
        case .verbose:
            return "--verbose"
        case .exit:
            return "--exit"
        case .dryRun:
            return "--dry-run"
        case .trace:
            return "--trace"
        case .local:
            return "--local"
        case .collectEffects:
            return "--collect-fx"
        case .offline:
            return "--offline"
        }
    }
    
}

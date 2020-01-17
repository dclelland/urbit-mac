//
//  UrbitCommandDebug.swift
//  Urbit
//
//  Created by Daniel Clelland on 13/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

class UrbitCommandDebug: UrbitCommand {
    
    override init(arguments: [String]) {
        super.init(arguments: ["bug"] + arguments)
    }
    
}

extension UrbitCommandDebug {
    
    enum DebugType {
        
        case validatePill(pill: URL, printPill: Bool = false, printBoot: Bool = false)
        case collectAllEffects(pier: URL)
        case eventBrowser(pier: URL)
        case validateEvents(pier: URL, first: UInt64? = nil, last: UInt64? = nil)
        case validateEffects(pier: URL, first: UInt64? = nil, last: UInt64? = nil)
        case checkDawn(keyfile: URL)
        case checkComet
        
        var arguments: [String] {
            var arguments: [String] = []
            switch self {
            case .validatePill(let pill, let printPill, let printBoot):
                arguments += ["validate-pill", pill.absoluteString]
                if printPill == true {
                    arguments += ["--print-pill"]
                }
                if printBoot == true {
                    arguments += ["--print-boot"]
                }
            case .collectAllEffects(let pier):
                arguments += ["collect-all-fx", pier.absoluteString]
            case .eventBrowser(let pier):
                arguments += ["validate-events", pier.absoluteString]
            case .validateEvents(let pier, let first, let last):
                arguments += ["event-browser", pier.absoluteString]
                if let first = first {
                    arguments += ["--first", String(first)]
                }
                if let last = last {
                    arguments += ["--last", String(last)]
                }
            case .validateEffects(let pier, let first, let last):
                arguments += ["validate-effects", pier.absoluteString]
                if let first = first {
                    arguments += ["--first", String(first)]
                }
                if let last = last {
                    arguments += ["--last", String(last)]
                }
            case .checkDawn(let keyfile):
                arguments += ["dawn", keyfile.absoluteString]
            case .checkComet:
                arguments += ["comet"]
            }
            return arguments
        }
        
    }
    
    convenience init(debugType: DebugType) {
        self.init(arguments: debugType.arguments)
    }
    
}

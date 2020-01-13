//
//  UrbitCommandNew.swift
//  Urbit
//
//  Created by Daniel Clelland on 13/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

struct UrbitCommandNew: UrbitCommand {
    
    enum BootType: UrbitCommand {
        
        case newComet
        case newFakeship(ship: String)
        case newFromKeyfile(keyfile: URL)
        
        var arguments: [String] {
            switch self {
            case .newComet:
                return ["--comet"]
            case .newFakeship(let ship):
                return ["--fake", ship]
            case .newFromKeyfile(let keyfile):
                return ["--keyfile", keyfile.absoluteString]
            }
        }
        
    }
    
    var pier: URL? = nil
    var bootType: BootType
    var pill: URL? = nil
    var lite: Bool = false
    var arvo: URL? = nil
    var options: [UrbitCommandOption] = []
    
    var arguments: [String] {
        var arguments = ["new"]
        if let pier = pier {
            arguments += [pier.absoluteString]
        }
        arguments += bootType.arguments
        if let pill = pill {
            arguments += [pill.absoluteString]
        }
        if lite == true {
            arguments += ["--lite"]
        }
        if let arvo = arvo {
            arguments += ["--arvo", arvo.absoluteString]
        }
        for option in options {
            arguments += option.arguments
        }
        return arguments
    }
    
}

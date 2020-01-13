//
//  UrbitProcessCommand.swift
//  Urbit
//
//  Created by Daniel Clelland on 11/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

protocol UrbitCommand {
    
    var arguments: [String] { get }
    
}

extension UrbitCommand {
    
    var process: Process {
        return Process(executableURL: Bundle.main.kingExecutableURL, arguments: arguments)
    }
    
}

extension UrbitCommandNew {
    
    static func startFakeZod() -> UrbitCommandNew {
        return UrbitCommandNew(
            pier: URL(string: "/Users/daniel/Code/Urbit/pier/zod")!,
            bootType: .newFakeship(ship: "zod")
        )
    }
    
}

extension UrbitCommandRun {
    
    static func restartFakeZod() -> UrbitCommandRun {
        return UrbitCommandRun(
            pier: URL(string: "/Users/daniel/Code/Urbit/pier/zod")!
        )
    }
    
}

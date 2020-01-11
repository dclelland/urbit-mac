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

extension Process {
    
    static func startFakeZod() -> Process {
        return Process(executableURL: Bundle.main.kingExecutableURL, arguments: ["-d", "-F", "/Users/daniel/Code/Urbit/pier/zod"])
    }
    
    static func restartFakeZod() -> Process {
        return Process(executableURL: Bundle.main.kingExecutableURL, arguments: ["-d", "/Users/daniel/Code/Urbit/pier/zod"])
    }
    
}

extension Process {

    static func startUrbitPlanet(name: String, file: String) -> Process {
        return Process(executableURL: Bundle.main.kingExecutableURL, arguments: ["-w", "/Users/daniel/Code/Urbit/pier/\(name)", "-k", file])
    }

    static func startUrbitComet(name: String) -> Process {
        return Process(executableURL: Bundle.main.kingExecutableURL, arguments: ["-c", "/Users/daniel/Code/Urbit/pier/\(name)"])
    }

    static func restartUrbit(name: String) -> Process {
        return Process(executableURL: Bundle.main.kingExecutableURL, arguments: ["/Users/daniel/Code/Urbit/pier/\(name)"])
    }

}

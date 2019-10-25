//
//  Process+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 20/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

extension Process {
    
    convenience init(currentDirectoryURL: URL, executableURL: URL, arguments: [String]) {
        self.init()
        self.currentDirectoryURL = currentDirectoryURL
        self.executableURL = executableURL
        self.arguments = arguments
    }
    
}

extension Process {
    
    static func startFakeZod() -> Process {
        return Process(currentDirectoryURL: URL(fileURLWithPath: "/Users/daniel/Code/Urbit/pier"), executableURL: Bundle.main.urbitExecutableURL, arguments: ["-d", "-F", "zod"])
    }
    
    static func restartFakeZod() -> Process {
        return Process(currentDirectoryURL: URL(fileURLWithPath: "/Users/daniel/Code/Urbit/pier"), executableURL: Bundle.main.urbitExecutableURL, arguments: ["-d", "zod"])
    }
    
}

extension Process {
    
    static func startUrbitPlanet(name: String, file: String) -> Process {
        return Process(currentDirectoryURL: URL(fileURLWithPath: "/Users/daniel/Code/Urbit/pier"), executableURL: Bundle.main.urbitExecutableURL, arguments: ["-w", name, "-k", file])
    }

    static func startUrbitComet(name: String) -> Process {
        return Process(currentDirectoryURL: URL(fileURLWithPath: "/Users/daniel/Code/Urbit/pier"), executableURL: Bundle.main.urbitExecutableURL, arguments: ["-c", name])
    }

    static func restartUrbit(name: String) -> Process {
        return Process(currentDirectoryURL: URL(fileURLWithPath: "/Users/daniel/Code/Urbit/pier"), executableURL: Bundle.main.urbitExecutableURL, arguments: [name])
    }
    
}

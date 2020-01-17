//
//  UrbitProcessCommand.swift
//  Urbit
//
//  Created by Daniel Clelland on 11/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

class UrbitCommand {
    
    let process: Process
    
    required init(arguments: [String] = []) {
        self.process = Process(executableURL: Bundle.main.urbitExecutableURL, arguments: arguments)
    }
    
}

extension UrbitCommand {
    
    static func help() -> Self {
        return Self.init(arguments: ["--help"])
    }
    
}

extension UrbitCommand {
    
//        let outputPipe = Pipe()
//        let errorPipe = Pipe()
        
//        process.standardOutput = outputPipe
//        process.standardError = errorPipe
//        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
//        errorPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
//        outputPipe.fileHandleForReading.readabilityHandler = { file in
//            let string = String(data: file.availableData, encoding: .utf8)!
//            print("output (readabilityHandler):", string)
//        }
//        errorPipe.fileHandleForReading.readabilityHandler = { file in
//            let string = String(data: file.availableData, encoding: .utf8)!
//            print("error (readabilityHandler):", string)
//        }

//        NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: outputPipe.fileHandleForReading, queue: nil) { notification in
//            let string = String(data: outputPipe.fileHandleForReading.availableData, encoding: .utf8)!
//            print("OUTPUT:")
//            print(string)
//        }
//
//        NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: errorPipe.fileHandleForReading, queue: nil) { notification in
//            let string = String(data: errorPipe.fileHandleForReading.availableData, encoding: .utf8)!
//            print("ERROR:")
//            print(string)
//        }
        
//        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
    
}

extension UrbitCommandNew {
    
    static func fakeZod() -> UrbitCommandNew {
        return UrbitCommandNew(
            pier: URL(string: "/Users/daniel/Code/Urbit/pier/zod")!,
            bootType: .newFakeship(ship: "zod"),
            pill: Bundle.main.urbitPillURL
        )
    }
    
}

extension UrbitCommandRun {
    
    static func fakeZod() -> UrbitCommandRun {
        return UrbitCommandRun(
            pier: URL(string: "/Users/daniel/Code/Urbit/pier/zod")!
        )
    }
    
}

extension UrbitCommandConnect {
    
    static func fakeZod() -> UrbitCommandConnect {
        return UrbitCommandConnect(
            pier: URL(string: "/Users/daniel/Code/Urbit/pier/zod")!
        )
    }
    
}

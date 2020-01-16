//
//  AppDelegate.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        let outputPipe = Pipe()
//        let errorPipe = Pipe()
        
        let command = UrbitCommandNew.startFakeZod()
//        let command = UrbitCommandRun.restartFakeZod()
//        let command = UrbitCommandConnect.connectFakeZod()
        let process = command.process
        
        print("URBIT BINARY ARGUMENTS:", (process.arguments ?? []).joined(separator: " "))
        
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
        
        command.process.run { result in
            print("PROCESS COMPLETED:", result)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

}

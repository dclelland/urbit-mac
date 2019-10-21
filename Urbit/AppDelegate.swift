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
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        
        let process = Process.restartFakeZod()
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        errorPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
//        outputPipe.fileHandleForReading.readabilityHandler = { file in
//            let string = String(data: file.availableData, encoding: .utf8)!
//            print("output:", string)
//        }

        NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: outputPipe.fileHandleForReading, queue: nil) { notification in
            let string = String(data: outputPipe.fileHandleForReading.availableData, encoding: .utf8)!
            print("OUTPUT:")
            print(string)
        }

        NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: errorPipe.fileHandleForReading, queue: nil) { notification in
            let string = String(data: errorPipe.fileHandleForReading.availableData, encoding: .utf8)!
            print("ERROR:")
            print(string)
        }
        
//        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        process.terminationHandler = { process in
            print("process terminated")
//            outputPipe.fileHandleForReading.readabilityHandler = nil
        }
        
        process.launch()
        process.waitUntilExit()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

}

//
//  AppDelegate.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
    
    var command = UrbitCommandRun.fakeZod()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        command.process.run { result in
            print("PROCESS COMPLETED:", result)
        }
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        command.process.interrupt()
        return .terminateNow
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        command.process.interrupt()
    }

}

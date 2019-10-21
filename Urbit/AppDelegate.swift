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
        let process = try! Process.run(Bundle.main.urbitExecutableURL, arguments: ["-F", "zod"]) { process in
            print("process terminated")
        }
        
        process.waitUntilExit()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

}

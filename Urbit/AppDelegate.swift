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
        let path = Bundle.main.path(forResource: "urbit", ofType: nil, inDirectory: "urbit-darwin-v0.9.0")
        let task = Process()
        task.launchPath = path
        
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

}

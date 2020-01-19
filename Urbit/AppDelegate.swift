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
    
    func applicationWillTerminate(_ aNotification: Notification) {
        command.process.terminate()
    }

}

extension AppDelegate {
    
    @IBAction func newShip(_ sender: Any?) {
        
    }
    
    @IBAction func newFakeship(_ sender: Any?) {
        
    }
    
    @IBAction func newComet(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    @IBAction func runShip(_ sender: Any?) {
        
    }
    
}

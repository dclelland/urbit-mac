//
//  AppDelegate.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
    
    var command: UrbitCommand? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        command?.process.terminate()
    }

}

extension AppDelegate {
    
    @IBAction func newShip(_ sender: Any?) {
        #warning("TODO: Remove '.key' from path component")
        NSOpenPanel(title: "Open Keyfile", fileTypes: ["key"]).begin().then { url in
            return NSSavePanel(title: "New Ship", fileName: url.lastPathComponent).begin()
        }.done { url in
            print("NEW SHIP:", url)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @IBAction func newFakeship(_ sender: Any?) {
        NSSavePanel(title: "New Fakeship").begin().done { url in
            #warning("TODO: Ship name required, e.g. 'zod'")
            print("NEW FAKESHIP:", url)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @IBAction func newComet(_ sender: Any?) {
        NSSavePanel(title: "New Comet").begin().done { url in
            print("NEW COMET:", url)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}

extension AppDelegate {
    
    @IBAction func runShip(_ sender: Any?) {
        NSOpenPanel(title: "Run Ship", canChooseDirectories: true, canChooseFiles: false).begin().done { url in
            self.command = UrbitCommandRun(pier: url)
            self.command?.process.run { result in
                print("PROCESS COMPLETED:", result)
            }
            #warning("TODO: Display run output; catch and show error if invalid pier; open new window with web view on completion")
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}

//
//  AppDelegate.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

    #warning("TODO: Pool of commands required")
    var command: UrbitCommand? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        #warning("TODO: Either show welcome window or restore state here")
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        command?.process.terminate()
    }

}

extension AppDelegate {
    
    #warning("TODO: Should run ship automatically after creating; refactor how `run` works; process should not be stored as an instance variable...?; add promise for chaining")
    #warning("TODO: Perhaps worth looking into Combine")
    
    @IBAction func newShip(_ sender: Any?) {
        #warning("TODO: Remove '.key' from path component")
        NSOpenPanel(title: "Open Keyfile", fileTypes: ["key"]).begin().then { keyfile in
            return NSSavePanel(title: "New Ship", fileName: keyfile.lastPathComponent).begin().done { pier in
                self.command = UrbitCommandNew(pier: pier, bootType: .newFromKeyfile(keyfile: keyfile), pill: Bundle.main.urbitPillURL)
                self.command?.process.run { result in
                    print("PROCESS COMPLETED:", result)
                }
            }
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @IBAction func newFakeship(_ sender: Any?) {
        NSSavePanel(title: "New Fakeship").begin().done { pier in
            #warning("TODO: Ship name required, e.g. 'zod'")
            print("NEW FAKESHIP:", pier)
            self.command = UrbitCommandNew(pier: pier, bootType: .newFakeship(ship: "zod"), pill: Bundle.main.urbitPillURL)
            self.command?.process.run { result in
                print("PROCESS COMPLETED:", result)
            }
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @IBAction func newComet(_ sender: Any?) {
        NSSavePanel(title: "New Comet").begin().done { pier in
            self.command = UrbitCommandNew(pier: pier, bootType: .newComet, pill: Bundle.main.urbitPillURL)
            self.command?.process.run { result in
                print("PROCESS COMPLETED:", result)
            }
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}

extension AppDelegate {
    
    @IBAction func runShip(_ sender: Any?) {
        NSOpenPanel(title: "Run Ship", canChooseDirectories: true, canChooseFiles: false).begin().done { pier in
            self.command = UrbitCommandRun(pier: pier)
            self.command?.process.run { result in
                print("PROCESS COMPLETED:", result)
            }
            #warning("TODO: Display run output; catch and show error if invalid pier; open new window with web view on completion")
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}

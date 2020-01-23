//
//  AppDelegate.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import UrbitClient
import LaunchAtLogin

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

//    #warning("TODO: Pool of commands required")
//    var command: UrbitCommand? = nil
    
    var piers = Persistent<[URL]>(key: "Piers", value: []) {
        didSet {
            refreshMenu()
        }
    }
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        statusItem.menu = NSMenu()
        statusItem.menu?.delegate = self
        
        refreshMenu()
        
        #warning("TODO: If there are no piers saved, show the welcome menu")
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
//        command?.process.terminate()
    }

}

extension AppDelegate: NSMenuDelegate {
    
    func menuWillOpen(_ menu: NSMenu) {
        refreshMenu()
    }
    
}

extension AppDelegate {
    
    @objc func newShip(_ sender: Any?) {
        
    }
    
    @objc func newFakeship(_ sender: Any?) {
        
    }
    
    @objc func newComet(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    @objc func open(_ sender: Any?) {
        
    }
    
    @objc func close(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    @objc func openInBrowser(_ sender: Any?) {
        
    }
    
    @objc func openInFinder(_ sender: Any?) {
        
    }
    
    @objc func openInTerminal(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    @objc func mountDesk(_ sender: Any?) {
        
    }
    
    @objc func unmountDesk(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    @objc func toggleLaunchAtLogin(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    private func refreshMenu() {
        self.statusItem.menu?.items = piers.value.map { pier in
            return NSMenuItem(
                title: pier.path,
                submenu: NSMenu(
                    items: [
                        NSMenuItem(
                            title: pier.path,
                            enabled: false
                        ),
                        .separator(),
                        NSMenuItem(
                            title: "Open in Browser",
                            action: #selector(AppDelegate.openInBrowser(_:)),
                            representedObject: pier
                        ),
                        NSMenuItem(
                            title: "Open in Finder",
                            action: #selector(AppDelegate.openInFinder(_:)),
                            representedObject: pier
                        ),
                        NSMenuItem(
                            title: "Open in Terminal",
                            action: #selector(AppDelegate.openInTerminal(_:)),
                            representedObject: pier
                        ),
                        .separator(),
                        NSMenuItem(
                            title: "Mount Desk...",
                            action: #selector(AppDelegate.openInTerminal(_:)),
                            representedObject: pier
                        ),
                        NSMenuItem(
                            title: "Unmount Desk...",
                            action: #selector(AppDelegate.openInTerminal(_:)),
                            representedObject: pier
                        ),
                        .separator(),
                        NSMenuItem(
                            title: "Close",
                            action: #selector(AppDelegate.close),
                            representedObject: pier
                        )
                    ]
                )
            )
        } + [
            .separator(),
            NSMenuItem(
                title: "New",
                submenu: NSMenu(
                    items: [
                        NSMenuItem(
                            title: "Ship...",
                            action: #selector(AppDelegate.newShip(_:))
                        ),
                        NSMenuItem(
                            title: "Fakeship...",
                            action: #selector(AppDelegate.newFakeship(_:))
                        ),
                        NSMenuItem(
                            title: "Comet...",
                            action: #selector(AppDelegate.newComet(_:))
                        )
                    ]
                )
            ),
            NSMenuItem(
                title: "Open...",
                action: #selector(AppDelegate.open(_:))
            ),
            .separator(),
            NSMenuItem(
                title: "Launch at Login",
                state: LaunchAtLogin.isEnabled ? .on : .off,
                action: #selector(AppDelegate.toggleLaunchAtLogin(_:))
            ),
            .separator(),
            NSMenuItem(
                title: "Quit \(Bundle.main.name)",
                action: #selector(NSApplication.terminate(_:))
            )
        ]
    }
    
}

//extension AppDelegate {
//
//    #warning("TODO: Should run ship automatically after creating; refactor how `run` works; process should not be stored as an instance variable...?; add promise for chaining")
//    #warning("TODO: Perhaps worth looking into Combine")
//
//    @IBAction func newShip(_ sender: Any?) {
//        #warning("TODO: Remove '.key' from path component")
//        NSOpenPanel(title: "Open Keyfile", fileTypes: ["key"]).begin().then { keyfile in
//            return NSSavePanel(title: "New Ship", fileName: keyfile.lastPathComponent).begin().done { pier in
//                self.command = UrbitCommandNew(pier: pier, bootType: .newFromKeyfile(keyfile: keyfile))
//                self.command?.process.run { result in
//                    print("PROCESS COMPLETED:", result)
//                }
//            }
//        }.catch { error in
//            NSAlert(error: error).runModal()
//        }
//    }
//
//    @IBAction func newFakeship(_ sender: Any?) {
//        NSSavePanel(title: "New Fakeship").begin().done { pier in
//            #warning("TODO: Ship name required, e.g. 'zod'")
//            print("NEW FAKESHIP:", pier)
//            self.command = UrbitCommandNew(pier: pier, bootType: .newFakeship(ship: "zod"))
//            self.command?.process.run { result in
//                print("PROCESS COMPLETED:", result)
//            }
//        }.catch { error in
//            NSAlert(error: error).runModal()
//        }
//    }
//
//    @IBAction func newComet(_ sender: Any?) {
//        NSSavePanel(title: "New Comet").begin().done { pier in
//            self.command = UrbitCommandNew(pier: pier, bootType: .newComet)
//            self.command?.process.run { result in
//                print("PROCESS COMPLETED:", result)
//            }
//        }.catch { error in
//            NSAlert(error: error).runModal()
//        }
//    }
//
//}
//
//extension AppDelegate {
//
//    @IBAction func runShip(_ sender: Any?) {
//        NSOpenPanel(title: "Run Ship", canChooseDirectories: true, canChooseFiles: false).begin().done { pier in
//            self.command = UrbitCommandRun(pier: pier)
//            self.command?.process.run { result in
//                print("PROCESS COMPLETED:", result)
//            }
//            #warning("TODO: Display run output; catch and show error if invalid pier; open new window with web view on completion")
//        }.catch { error in
//            NSAlert(error: error).runModal()
//        }
//    }
//
//}

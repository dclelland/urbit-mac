//
//  AppDelegate.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import UrbitClient
import Defaults
import LaunchAtLogin

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        statusItem.menu = NSMenu()
        statusItem.menu?.delegate = self
        
        refreshMenu()
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
    
    //    #warning("TODO: Should run ship automatically after creating; refactor how `run` works; process should not be stored as an instance variable...?; add promise for chaining")
    //    #warning("TODO: Perhaps worth looking into Combine")
    
    @objc func newShip(_ sender: Any?) {
        #warning("TODO: Remove '.key' from path component")
        NSOpenPanel(title: "Open Keyfile", fileTypes: ["key"]).begin().then { keyfile in
            return NSSavePanel(title: "New Ship", fileName: keyfile.lastPathComponent).begin().done { url in
                UrbitCommandNew(pier: url, bootType: .newFromKeyfile(keyfile: keyfile)).process.run { result in
                    Pier.all.append(Pier(url: url))
                    print("PROCESS COMPLETED:", result)
                }
            }
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func newFakeship(_ sender: Any?) {
        NSSavePanel(title: "New Fakeship").begin().done { url in
            #warning("TODO: Ship name required, e.g. 'zod'")
            print("NEW FAKESHIP:", url)
            UrbitCommandNew(pier: url, bootType: .newFakeship(ship: "zod")).process.run { result in
                Pier.all.append(Pier(url: url))
                print("PROCESS COMPLETED:", result)
            }
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func newComet(_ sender: Any?) {
        NSSavePanel(title: "New Comet").begin().done { url in
            UrbitCommandNew(pier: url, bootType: .newComet).process.run { result in
                Pier.all.append(Pier(url: url))
                print("PROCESS COMPLETED:", result)
            }
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}

extension AppDelegate {
    
    @objc func open(_ sender: Any?) {
        NSOpenPanel(title: "Run Ship", canChooseDirectories: true, canChooseFiles: false).begin().done { url in
            #warning("FIXME: This won't quite work")
            UrbitCommandRun(pier: url).process.run { result in
                Pier.all.append(Pier(url: url))
                print("PROCESS COMPLETED:", result)
            }
            #warning("TODO: Display run output; catch and show error if invalid pier; open new window with web view on completion")
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func openBridge(_ sender: Any?) {
        NSWorkspace.shared.open(.urbitBridgeURL)
    }
    
    @objc func close(_ sender: Any?) {
        guard let pier = (sender as? NSMenuItem)?.representedObject as? Pier else {
            return
        }
        
        Pier.all.removeAll(where: { $0 == pier })
    }
    
}

extension AppDelegate {
    
    @objc func openInFinder(_ sender: Any?) {
        guard let pier = (sender as? NSMenuItem)?.representedObject as? Pier else {
            return
        }
        
        NSWorkspace.shared.openInFinder(pier.url)
    }
    
    @objc func openInBrowser(_ sender: Any?) {
        guard let pier = (sender as? NSMenuItem)?.representedObject as? Pier else {
            return
        }
        
        #warning("Get the real URL")
        
        NSWorkspace.shared.openInBrowser(URL(string: "http://localhost:8080/")!)
    }
    
    @objc func openInTerminal(_ sender: Any?) {
        guard let pier = (sender as? NSMenuItem)?.representedObject as? Pier else {
            return
        }
        
        NSWorkspace.shared.openInTerminal(pier.url, script: UrbitCommandConnect(pier: pier.url).script!)
    }
    
}

extension AppDelegate {
    
    @objc func mountDesk(_ sender: Any?) {
        
    }
    
    @objc func unmountDesk(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    @objc func showLog(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    @objc func toggleLaunchAtLogin(_ sender: Any?) {
        
    }
    
}

extension AppDelegate {
    
    private func refreshMenu() {
        self.statusItem.menu?.items = Defaults[.piers].map { pier in
            return NSMenuItem(
                title: pier.name,
                submenu: NSMenu(
                    items: [
                        NSMenuItem(
                            title: pier.url.path,
                            enabled: false
                        ),
                        .separator(),
                        NSMenuItem(
                            title: "Open in Finder",
                            action: #selector(AppDelegate.openInFinder(_:)),
                            representedObject: pier
                        ),
                        NSMenuItem(
                            title: "Open in Browser",
                            action: #selector(AppDelegate.openInBrowser(_:)),
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
                            title: "Show Log...",
                            action: #selector(AppDelegate.showLog(_:)),
                            representedObject: pier
                        ),
                        .separator(),
                        NSMenuItem(
                            title: "Close",
                            action: #selector(AppDelegate.close(_:)),
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
            NSMenuItem(
                title: "Open Bridge",
                action: #selector(AppDelegate.openBridge(_:))
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

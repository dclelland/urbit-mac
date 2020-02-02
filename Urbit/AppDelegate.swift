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
        statusItem.menu = NSMenu.piers(Defaults[.piers])
        statusItem.menu?.delegate = self
    }

}

extension AppDelegate: NSMenuDelegate {
    
    func menuWillOpen(_ menu: NSMenu) {
        statusItem.menu = NSMenu.piers(Defaults[.piers])
        statusItem.menu?.delegate = self
    }
    
}

extension NSMenu {
    
    static func piers(_ piers: [Pier]) -> NSMenu {
        return NSMenu(
            items: piers.sorted().map { pier in
                return NSMenuItem(
                    title: pier.name,
                    submenu: NSMenu.pier(pier)
                )
            } + [
                .separator(),
                NSMenuItem(
                    title: "New",
                    submenu: NSMenu(
                        items: [
                            NSMenuItem(
                                title: "Ship...",
                                action: {
                                    #warning("TODO: Remove '.key' from path component")
                                    NSOpenPanel(title: "Open Keyfile", fileTypes: ["key"]).begin().then { keyfile in
                                        return NSSavePanel(title: "New Ship", fileName: keyfile.lastPathComponent).begin().done { url in
                                            try Pier(url: url).open()
                                            UrbitCommandNew(pier: url, bootType: .newFromKeyfile(keyfile)).process.run { result in
                                                print("PROCESS COMPLETED:", result)
                                            }
                                        }
                                    }.catch { error in
                                        NSAlert(error: error).runModal()
                                    }
                                }
                            ),
                            NSMenuItem(
                                title: "Fakeship...",
                                action: {
                                    NSSavePanel(title: "New Fakeship").begin().done { url in
                                        #warning("TODO: Ship name required, e.g. 'zod'")
                                        print("NEW FAKESHIP:", url)
                                        try Pier(url: url).open()
                                        UrbitCommandNew(pier: url, bootType: .newFakeship("zod")).process.run { result in
                                            print("PROCESS COMPLETED:", result)
                                        }
                                    }.catch { error in
                                        NSAlert(error: error).runModal()
                                    }
                                }
                            ),
                            NSMenuItem(
                                title: "Comet...",
                                action: {
                                    NSSavePanel(title: "New Comet").begin().done { url in
                                        try Pier(url: url).open()
                                        UrbitCommandNew(pier: url, bootType: .newComet).process.run { result in
                                            print("PROCESS COMPLETED:", result)
                                        }
                                    }.catch { error in
                                        NSAlert(error: error).runModal()
                                    }
                                }
                            )
                        ]
                    )
                ),
                NSMenuItem(
                    title: "Open...",
                    action: {
                        NSOpenPanel(title: "Open Pier", canChooseDirectories: true, canChooseFiles: false).begin().done { url in
                            try Pier(url: url).open()
                        }.catch { error in
                            NSAlert(error: error).runModal()
                        }
                    }
                ),
                NSMenuItem(
                    title: "Open Bridge",
                    action: {
                        NSWorkspace.shared.open(.urbitBridgeURL)
                    }
                ),
                .separator(),
                NSMenuItem(
                    title: "Launch at Login",
                    state: LaunchAtLogin.isEnabled ? .on : .off,
                    action: {
                        LaunchAtLogin.isEnabled.toggle()
                    }
                ),
                .separator(),
                NSMenuItem(
                    title: "Quit \(Bundle.main.name)",
                    action: #selector(NSApplication.terminate(_:))
                )
            ]
        )
    }
    
    static func pier(_ pier: Pier) -> NSMenu {
        return NSMenu(
            items: [
                NSMenuItem(
                    title: pier.url.path,
                    enabled: false
                ),
                .separator(),
                NSMenuItem(
                    title: "Start",
                    action: {
                        pier.ship.start()
                    }
                ),
                NSMenuItem(
                    title: "Stop",
                    action: {
                        pier.ship.stop()
                    }
                ),
                .separator(),
                NSMenuItem(
                    title: "Open in Finder",
                    action: {
                        NSWorkspace.shared.openInFinder(pier.url)
                    }
                ),
                NSMenuItem(
                    title: "Open in Browser",
                    action: {
                        #warning("Get the real URL")
                        NSWorkspace.shared.openInBrowser(URL(string: "http://localhost:8080/")!)
                    }
                ),
                NSMenuItem(
                    title: "Open in Terminal",
                    action: {
                        NSWorkspace.shared.openInTerminal(pier.url, script: UrbitCommandConnect(pier: pier.url).script!)
                    }
                ),
                .separator(),
                NSMenuItem(
                    title: "Mount Desk...",
                    action: {}
                ),
                NSMenuItem(
                    title: "Unmount Desk...",
                    action: {}
                ),
                .separator(),
                NSMenuItem(
                    title: "Show Log...",
                    action: {}
                ),
                .separator(),
                NSMenuItem(
                    title: "Close",
                    action: {
                        pier.close()
                    }
                )
            ]
        )
    }
    
}

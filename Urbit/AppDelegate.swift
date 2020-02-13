//
//  AppDelegate.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import Defaults
import LaunchAtLogin
import UrbitKit

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSUserNotificationCenter.default.delegate = self
        
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

extension AppDelegate: NSUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
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
                                    NSWindowController(window: NSWindow(title: "New Ship", rootView: NewShipView())).showWindow(nil)
                                }
                            ),
                            NSMenuItem(
                                title: "Fakeship...",
                                action: {
                                    NSWindowController(window: NSWindow(title: "New Fakeship", rootView: NewFakeshipView())).showWindow(nil)
                                }
                            ),
                            NSMenuItem(
                                title: "Comet...",
                                action: {
                                    NSWindowController(window: NSWindow(title: "New Comet", rootView: NewCometView())).showWindow(nil)
                                }
                            )
                        ]
                    )
                ),
                NSMenuItem(
                    title: "Open...",
                    action: {
                        NSOpenPanel.open(
                            title: "Open Pier",
                            canChooseDirectories: true,
                            canChooseFiles: false
                        ).then { url in
                            return Pier(url: url).open()
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
                        pier.start().catch { error in
                            NSAlert(error: error).runModal()
                        }
                    }
                ),
                NSMenuItem(
                    title: "Stop",
                    action: {
                        pier.stop().catch { error in
                            NSAlert(error: error).runModal()
                        }
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

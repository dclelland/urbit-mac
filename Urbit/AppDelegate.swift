//
//  AppDelegate.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import SwiftUI
import LaunchAtLogin
import UrbitKit

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NotificationCenter.default.addObserver(self, selector: #selector(shipDidUpdateState(_:)), name: Ship.didUpdateStateNotification, object: nil)
        
        NSUserNotificationCenter.default.delegate = self
        
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        statusItem.menu = NSMenu.ships(Ship.all)
        statusItem.menu?.delegate = self
    }

}

extension AppDelegate {
    
    @objc private func shipDidUpdateState(_ notification: Notification) {
        guard
            let ship = notification.object as? Ship,
            let oldState = notification.userInfo?[Ship.oldStateNotificationUserInfoKey] as? Ship.State,
            let newState = notification.userInfo?[Ship.newStateNotificationUserInfoKey] as? Ship.State
            else { return }
        
        let notification: NSUserNotification? = {
            switch (oldState, newState) {
            case (.stopped(let oldState), .started(let newState)):
                switch (oldState, newState) {
                case (_, .creating):
                    return NSUserNotification(
                        title: "Started creating ship \"\(ship.name)\"",
                        informativeText: ship.url.abbreviatedPath
                    )
                case (_, .running):
                    return NSUserNotification(
                        title: "Started running ship \"\(ship.name)\"",
                        informativeText: ship.url.abbreviatedPath
                    )
                }
            case (.started(let oldState), .stopped(let newState)):
                switch (oldState, newState) {
                case (.creating, .cancelled):
                    return NSUserNotification(
                        title: "Cancelled creating ship \"\(ship.name)\"",
                        informativeText: ship.url.abbreviatedPath
                    )
                case (.creating, .finished):
                    return NSUserNotification(
                        title: "Finished creating ship \"\(ship.name)\"",
                        informativeText: ship.url.abbreviatedPath
                    )
                case (.creating, .failure(let error)):
                    return NSUserNotification(
                        title: "Failed creating ship \"\(ship.name)\"",
                        informativeText: error.localizedDescription
                    )
                case (.running, .cancelled):
                    return NSUserNotification(
                        title: "Cancelled running ship \"\(ship.name)\"",
                        informativeText: ship.url.abbreviatedPath
                    )
                case (.running, .finished):
                    return NSUserNotification(
                        title: "Finished running ship \"\(ship.name)\"",
                        informativeText: ship.url.abbreviatedPath
                    )
                case (.running, .failure(let error)):
                    return NSUserNotification(
                        title: "Failed running ship \"\(ship.name)\"",
                        informativeText: error.localizedDescription
                    )
                }
            default:
                return nil
            }
        }()
        
        if let notification = notification {
            NSUserNotificationCenter.default.deliver(notification)
        }
    }
    
}

extension AppDelegate: NSMenuDelegate {
    
    func menuWillOpen(_ menu: NSMenu) {
        statusItem.menu = NSMenu.ships(Ship.all)
        statusItem.menu?.delegate = self
    }
    
}

extension AppDelegate: NSUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
}

extension NSMenu {
    
    static func ships(_ ships: [Ship]) -> NSMenu {
        return NSMenu(
            items: ships.sorted().map { ship in
                return NSMenuItem(
                    title: ship.name,
                    submenu: NSMenu.ship(ship)
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
                                    let window = NSWindow(title: "New Ship")
                                    window.contentView = NSHostingView(
                                        rootView: NewShipView(
                                            create: { [weak window] url, keyfileURL in
                                                window?.close()
                                                do {
                                                    try Ship(url: url).new(bootType: .newFromKeyfile(keyfileURL))
                                                } catch let error {
                                                    NSAlert(error: error).runModal()
                                                }
                                            }
                                        )
                                    )
                                    let windowController = NSWindowController(window: window)
                                    windowController.window?.center()
                                    windowController.showWindow(nil)
                                    NSApp.activate(ignoringOtherApps: true)
                                }
                            ),
                            NSMenuItem(
                                title: "Fakeship...",
                                action: {
                                    let window = NSWindow(title: "New Fakeship")
                                    window.contentView = NSHostingView(
                                        rootView: NewFakeshipView(
                                            create: { [weak window] name, url in
                                                window?.close()
                                                do {
                                                    try Ship(url: url).new(bootType: .newFakeship(name))
                                                } catch let error {
                                                    NSAlert(error: error).runModal()
                                                }
                                            }
                                        )
                                    )
                                    let windowController = NSWindowController(window: window)
                                    windowController.window?.center()
                                    windowController.showWindow(nil)
                                    NSApp.activate(ignoringOtherApps: true)
                                }
                            ),
                            NSMenuItem(
                                title: "Comet...",
                                action: {
                                    let window = NSWindow(title: "New Comet")
                                    window.contentView = NSHostingView(
                                        rootView: NewCometView(
                                            create: { [weak window] url in
                                                window?.close()
                                                do {
                                                    try Ship(url: url).new(bootType: .newComet)
                                                } catch let error {
                                                    NSAlert(error: error).runModal()
                                                }
                                            }
                                        )
                                    )
                                    let windowController = NSWindowController(window: window)
                                    windowController.window?.center()
                                    windowController.showWindow(nil)
                                    NSApp.activate(ignoringOtherApps: true)
                                }
                            )
                        ]
                    )
                ),
                NSMenuItem(
                    title: "Open...",
                    action: {
                        NSOpenPanel(title: "Open Ship", canChooseDirectories: true, canChooseFiles: false).begin { (url: URL) in
                            do {
                                try Ship(url: url).open()
                            } catch let error {
                                NSAlert(error: error).runModal()
                            }
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
    
    static func ship(_ ship: Ship) -> NSMenu {
        return NSMenu(
            items: [
                NSMenuItem(
                    title: {
                        switch ship.state {
                        case .stopped(.cancelled):
                            return "Ready"
                        case .stopped(.finished):
                            return "Ready"
                        case .stopped(.failure(let error)):
                            return "Stopped: \(error.localizedDescription)"
                        case .started(.creating):
                            return "Creating"
                        case .started(.running):
                            return "Running"
                        }
                    }(),
                    enabled: false
                ),
                NSMenuItem(
                    title: ship.url.abbreviatedPath,
                    enabled: false
                ),
                .separator(),
                NSMenuItem(
                    title: "Start",
                    action: {
                        ship.start()
                    }
                ),
                NSMenuItem(
                    title: "Stop",
                    action: {
                        ship.stop()
                    }
                ),
                .separator(),
                NSMenuItem(
                    title: "Open in Finder",
                    action: {
                        NSWorkspace.shared.openInFinder(ship.url)
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
                        NSWorkspace.shared.openInTerminal(ship.url, script: UrbitCommandConnect(pier: ship.url).script!)
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
                        ship.close()
                    }
                )
            ]
        )
    }
    
}

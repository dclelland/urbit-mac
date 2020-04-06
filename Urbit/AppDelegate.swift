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
    
    internal var pierObserverToken: NSObjectProtocol?
    internal var shipObserverToken: NSObjectProtocol?
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Pier.addObserver(self)
        Ship.addObserver(self)
        
        NSUserNotificationCenter.default.delegate = self
        
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        statusItem.menu = NSMenu.ships(Ship.all)
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        for ship in Ship.all {
            ship.close()
        }
        return .terminateNow
    }

}

extension AppDelegate: PierObserver {
    
    func pierDidUpdate(from oldPiers: [Pier], to newPiers: [Pier]) {
        statusItem.menu = NSMenu.ships(Ship.all)
    }
    
}

extension AppDelegate: ShipObserver {
    
    func shipDidUpdate(_ ship: Ship, from oldState: Ship.State, to newState: Ship.State) {
        statusItem.menu = NSMenu.ships(Ship.all)
        
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
                                                try Ship(url: url).new(bootType: .newFromKeyfile(keyfileURL))
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
                                                try Ship(url: url).new(bootType: .newFakeship(name))
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
                                                try Ship(url: url).new(bootType: .newComet)
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
                        NSOpenPanel(title: "Open Ship", canChooseDirectories: true, canChooseFiles: false).begin { url in
                            try Ship(url: url).open()
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
                    title: "Start Running",
                    enabled: ship.state.isStopped,
                    action: ship.start
                ),
                NSMenuItem(
                    title: "Stop Running",
                    enabled: ship.state.isStarted,
                    action: ship.stop
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
                    enabled: ship.state.isRunning,
                    action: {
                        #warning("Get the real URL")
                        NSWorkspace.shared.openInBrowser(URL(string: "http://localhost:8080/")!)
                    }
                ),
                NSMenuItem(
                    title: "Open in Terminal",
                    enabled: ship.state.isRunning,
                    action: {
                        NSWorkspace.shared.openInTerminal(ship.url, script: UrbitCommandConnect(pier: ship.url).script!)
                    }
                ),
                .separator(),
                NSMenuItem(
                    title: "Mount Desk...",
                    enabled: false,
                    action: {}
                ),
                NSMenuItem(
                    title: "Unmount Desk...",
                    enabled: false,
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
                    action: ship.close
                )
            ]
        )
    }
    
}

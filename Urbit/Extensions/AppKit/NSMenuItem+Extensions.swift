//
//  NSMenuItem+Extensions.swift
//  urbit-mac
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

extension NSMenuItem {
    
    convenience init(title: String, state: NSControl.StateValue = .off, enabled: Bool = true, action: Selector? = nil, keyEquivalent: String = "", representedObject: Any? = nil, submenu: NSMenu? = nil) {
        self.init(title: title, action: enabled ? action : nil, keyEquivalent: keyEquivalent)
        self.state = state
        self.isEnabled = enabled
        self.representedObject = representedObject
        self.submenu = submenu
    }
    
}

extension NSMenuItem {
    
    convenience init(title: String, state: NSControl.StateValue = .off, enabled: Bool = true, action: @escaping () -> Void, keyEquivalent: String = "", representedObject: Any? = nil, submenu: NSMenu? = nil) {
        self.init(
            title: title,
            state: state,
            enabled: enabled,
            action: #selector(performRepresentedObjectAction(_:)),
            keyEquivalent: keyEquivalent,
            representedObject: action,
            submenu: submenu
        )
        self.target = self
    }
    
}

extension NSMenuItem {
    
    @objc func performRepresentedObjectAction(_ sender: Any?) {
        guard let action = (sender as? NSMenuItem)?.representedObject as? () -> Void else {
            return
        }
        
        action()
    }
    
}

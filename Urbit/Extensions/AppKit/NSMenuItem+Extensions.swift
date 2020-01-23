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
        self.init(title: title, action: action, keyEquivalent: "")
        self.state = state
        self.isEnabled = enabled
        self.representedObject = representedObject
        self.submenu = submenu
    }
    
}

//
//  NSWindow+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

extension NSWindow {
    
    convenience init(styleMask: NSWindow.StyleMask = [.titled, .closable, .resizable], title: String) {
        self.init()
        self.styleMask = styleMask
        self.title = title
    }
    
}

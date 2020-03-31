//
//  NSWindow+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit
import SwiftUI

extension NSWindow {
    
    convenience init<Content>(styleMask: NSWindow.StyleMask = [.titled, .closable, .resizable], title: String, rootView: Content) where Content : View {
        self.init()
        self.styleMask = styleMask
        self.title = title
        self.contentView = NSHostingView(rootView: rootView)
    }
    
}

//
//  NSMenu+Extensions.swift
//  urbit-mac
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

extension NSMenu {
    
    convenience init(title: String = "", items: [NSMenuItem]) {
        self.init(title: title)
        self.items = items
    }
    
}

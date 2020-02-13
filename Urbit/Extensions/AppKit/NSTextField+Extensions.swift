//
//  NSTextField+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 12/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

extension NSTextField {
    
    convenience init(stringValue: String = "", placeholderString: String = "") {
        self.init(frame: NSRect(x: 0.0, y: 0.0, width: 240.0, height: 22.0))
        self.stringValue = stringValue
        self.placeholderString = placeholderString
    }
    
}

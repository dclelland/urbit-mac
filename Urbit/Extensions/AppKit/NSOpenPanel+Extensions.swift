//
//  NSOpenPanel+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 20/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

extension NSOpenPanel {
    
    convenience init(canChooseDirectories: Bool, canChooseFiles: Bool) {
        self.init()
        self.canChooseDirectories = canChooseDirectories
        self.canChooseFiles = canChooseFiles
    }
    
}
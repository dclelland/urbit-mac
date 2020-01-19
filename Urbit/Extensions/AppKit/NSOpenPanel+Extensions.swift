//
//  NSOpenPanel+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 20/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

extension NSOpenPanel {
    
    convenience init(title: String = "", canChooseDirectories: Bool, canChooseFiles: Bool) {
        self.init(title: title)
        self.canChooseDirectories = canChooseDirectories
        self.canChooseFiles = canChooseFiles
    }
    
}

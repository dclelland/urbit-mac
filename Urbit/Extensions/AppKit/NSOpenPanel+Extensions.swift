//
//  NSOpenPanel+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 20/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit
import PromiseKit

extension NSOpenPanel {
    
    convenience init(title: String = "", fileName: String = "", fileTypes: [String] = [], canChooseDirectories: Bool = true, canChooseFiles: Bool = true) {
        self.init(title: title, fileName: fileName, fileTypes: fileTypes)
        self.canChooseDirectories = canChooseDirectories
        self.canChooseFiles = canChooseFiles
    }
    
}

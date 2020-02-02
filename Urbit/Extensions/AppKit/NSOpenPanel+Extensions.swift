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

extension NSOpenPanel {
    
    static func open(title: String = "", fileName: String = "", fileTypes: [String] = [], canChooseDirectories: Bool = true, canChooseFiles: Bool = true, ignoringOtherApps flag: Bool = true) -> Promise<URL> {
        NSApp.activate(ignoringOtherApps: flag)
        let openPanel = NSOpenPanel(title: title, fileName: fileName, fileTypes: fileTypes, canChooseDirectories: canChooseDirectories, canChooseFiles: canChooseFiles)
        return openPanel.promise()
    }
    
}

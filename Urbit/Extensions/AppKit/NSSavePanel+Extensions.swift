//
//  NSSavePanel+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 22/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import Combine

extension NSSavePanel {
    
    convenience init(title: String = "", fileName: String = "", fileTypes: [String] = []) {
        self.init()
        self.title = title
        self.nameFieldStringValue = fileName
        self.allowedFileTypes = fileTypes
        self.showsTagField = false
    }
    
}

extension NSSavePanel {
    
    func begin(ignoringOtherApps flag: Bool = true, completionHandler handler: @escaping (URL) -> Void) {
        NSApp.activate(ignoringOtherApps: flag)
        begin { response in
            if let url = self.url, response == .OK {
                handler(url)
            }
        }
    }
    
    func begin(ignoringOtherApps flag: Bool = true, completionHandler handler: @escaping (URL) throws -> Void) {
        begin(ignoringOtherApps: flag) { url in
            do {
                try handler(url)
            } catch let error {
                NSAlert(error: error).runModal()
            }
        }
    }

}

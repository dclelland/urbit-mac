//
//  NSSavePanel+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 22/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import PromiseKit

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
    
    static func save(title: String = "", fileName: String = "", fileTypes: [String] = [], ignoringOtherApps flag: Bool = true) -> Promise<URL> {
        NSApp.activate(ignoringOtherApps: flag)
        let savePanel = NSSavePanel(title: title, fileName: fileName, fileTypes: fileTypes)
        return savePanel.promise()
    }
    
}

extension NSSavePanel {
    
    func promise() -> Promise<URL> {
        return Promise { resolver in
            self.begin { response in
                if let url = self.url, response == .OK {
                    resolver.fulfill(url)
                } else {
                    resolver.reject(PMKError.cancelled)
                }
            }
        }
    }
    
}

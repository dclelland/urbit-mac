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
    
    func begin() -> Promise<URL> {
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

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
    
    convenience init(fileName: String = "", fileType: String) {
        self.init(fileName: fileName, fileTypes: [fileType])
    }
    
    convenience init(fileName: String = "", fileTypes: [String] = []) {
        self.init()
        self.nameFieldStringValue = fileName
        self.allowedFileTypes = fileTypes
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

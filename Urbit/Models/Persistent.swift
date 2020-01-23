//
//  Persistent.swift
//  3LED
//
//  Created by Daniel Clelland on 18/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

public struct Persistent<T> {
    
    public let key: String
    
    public init(key: String, value: T) {
        self.key = key
        self.registerDefault(value: value, forKey: key)
    }
    
    public var value: T {
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
        get {
            return UserDefaults.standard.object(forKey: key) as! T
        }
    }
    
    private func registerDefault(value: T, forKey key: String) {
        UserDefaults.standard.register(defaults: [key: value])
    }
    
}

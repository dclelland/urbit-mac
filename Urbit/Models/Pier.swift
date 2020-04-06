//
//  Pier.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation
import Defaults

extension Defaults.Keys {
    
    fileprivate static let piers = Key<[Pier]>("piers", default: [])
    
}

extension Pier {
    
    static let didUpdateNotification = NSNotification.Name("piersDidUpdate")
    
    static let oldPiersNotificationUserInfoKey = "oldPiers"
    
    static let newPiersNotificationUserInfoKey = "newPiers"
    
}

extension Pier {
    
    static var all: [Pier] {
        get {
            return Defaults[.piers]
        }
        set {
            defer {
                NotificationCenter.default.post(
                    name: Pier.didUpdateNotification,
                    object: self,
                    userInfo: [
                        Pier.oldPiersNotificationUserInfoKey: all,
                        Pier.newPiersNotificationUserInfoKey: newValue
                    ]
                )
            }
            Defaults[.piers] = newValue
        }
    }
    
}

struct Pier: Codable {
    
    var url: URL
    
}

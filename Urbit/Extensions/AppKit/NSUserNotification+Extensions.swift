//
//  NSUserNotification+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 3/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

extension NSUserNotification {
    
    convenience init(title: String?, subtitle: String? = nil, informativeText: String? = nil, soundName: String? = nil) {
        self.init()
        self.title = title
        self.subtitle = subtitle
        self.informativeText = informativeText
        self.soundName = soundName
    }
    
}

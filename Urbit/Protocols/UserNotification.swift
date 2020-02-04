//
//  UserNotification.swift
//  Urbit
//
//  Created by Daniel Clelland on 5/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

protocol UserNotification {
    
    var userNotification: NSUserNotification? { get }
    
}

extension UserNotification {
    
    func deliverUserNotification(with notificationCenter: NSUserNotificationCenter = .default) {
        guard let userNotification = userNotification else {
            return
        }
        
        notificationCenter.deliver(userNotification)
    }
    
}

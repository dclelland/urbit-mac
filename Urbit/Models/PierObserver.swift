//
//  PierObserver.swift
//  Urbit
//
//  Created by Daniel Clelland on 6/04/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

protocol PierObserver: class {
    
    var pierObserverToken: NSObjectProtocol? { get set }
    
    func pierDidUpdate(from oldPiers: [Pier], to newPiers: [Pier])
    
}

extension Pier {
    
    static func addObserver(_ observer: PierObserver) {
        observer.pierObserverToken = NotificationCenter.default.addObserver(forName: Pier.didUpdateNotification, object: nil, queue: nil) { [weak observer] notification in
            guard
                let oldPiers = notification.userInfo?[Pier.oldPiersNotificationUserInfoKey] as? [Pier],
                let newPiers = notification.userInfo?[Pier.newPiersNotificationUserInfoKey] as? [Pier]
                else { return }
            
            observer?.pierDidUpdate(from: oldPiers, to: newPiers)
        }
    }
    
    static func removeObserver(_ observer: PierObserver) {
        observer.pierObserverToken = observer.pierObserverToken.flatMap { pierObserverToken in
            NotificationCenter.default.removeObserver(pierObserverToken, name: Pier.didUpdateNotification, object: nil)
            return nil
        }
    }
    
}

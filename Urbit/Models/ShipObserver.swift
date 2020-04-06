//
//  ShipObserver.swift
//  Urbit
//
//  Created by Daniel Clelland on 6/04/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

protocol ShipObserver: class {
    
    var shipObserverToken: NSObjectProtocol? { get set }
    
    func shipDidUpdate(_ ship: Ship, from oldState: Ship.State, to newState: Ship.State)
    
}

extension Ship {
    
    static func addObserver(_ observer: ShipObserver) {
        observer.shipObserverToken = NotificationCenter.default.addObserver(forName: Ship.didUpdateStateNotification, object: nil, queue: nil) { [weak observer] notification in
            guard
                let ship = notification.object as? Ship,
                let oldState = notification.userInfo?[Ship.oldShipStateNotificationUserInfoKey] as? Ship.State,
                let newState = notification.userInfo?[Ship.newShipStateNotificationUserInfoKey] as? Ship.State
                else { return }
            
            observer?.shipDidUpdate(ship, from: oldState, to: newState)
        }
    }
    
    static func removeObserver(_ observer: ShipObserver) {
        observer.shipObserverToken = observer.shipObserverToken.flatMap { shipObserverToken in
            NotificationCenter.default.removeObserver(shipObserverToken, name: Ship.didUpdateStateNotification, object: nil)
            return nil
        }
    }
    
}

//
//  Ship.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation
import Combine
import UrbitKit

protocol ShipObserver: class {
    
    var shipObserverToken: NSObjectProtocol? { get set }
    
    func ship(_ ship: Ship, didUpdateStateFrom oldState: Ship.State, to newState: Ship.State)
    
}

extension Ship {
    
    static func addObserver(_ observer: ShipObserver) {
        observer.shipObserverToken = NotificationCenter.default.addObserver(forName: Ship.didUpdateStateNotification, object: nil, queue: nil) { [weak observer] notification in
            guard
                let ship = notification.object as? Ship,
                let oldState = notification.userInfo?[Ship.oldStateNotificationUserInfoKey] as? Ship.State,
                let newState = notification.userInfo?[Ship.newStateNotificationUserInfoKey] as? Ship.State
                else { return }
            
            observer?.ship(ship, didUpdateStateFrom: oldState, to: newState)
        }
    }
    
    static func removeObserver(_ observer: ShipObserver) {
        observer.shipObserverToken = observer.shipObserverToken.flatMap { shipObserverToken in
            NotificationCenter.default.removeObserver(shipObserverToken, name: Ship.didUpdateStateNotification, object: nil)
            return nil
        }
    }
    
}

extension Ship {
    
    static let didUpdateStateNotification = NSNotification.Name("shipDidUpdateState")
    
    static let oldStateNotificationUserInfoKey = "oldState"
    
    static let newStateNotificationUserInfoKey = "newState"
    
}

extension Ship {
    
    static var all: [Ship] = Pier.all.map { Ship(pier: $0) } {
        didSet {
            Pier.all = all.map { $0.pier }
        }
    }
    
}

class Ship {
    
    enum State {
        
        enum StoppedState {
            
            case cancelled
            case finished
            case failure(_ error: Error)
            
        }
        
        enum StartedState {
            
            case creating(subscriber: AnyCancellable)
            case running(subscriber: AnyCancellable)
            
            var subscriber: AnyCancellable {
                switch self {
                case .creating(let subscriber):
                    return subscriber
                case .running(let subscriber):
                    return subscriber
                }
            }
            
        }
        
        case stopped(_ state: StoppedState)
        case started(_ state: StartedState)
        
    }
    
    var pier: Pier
    
    var state: State = .stopped(.finished) {
        didSet {
            NotificationCenter.default.post(
                name: Ship.didUpdateStateNotification,
                object: self,
                userInfo: [
                    Ship.oldStateNotificationUserInfoKey: oldValue,
                    Ship.newStateNotificationUserInfoKey: state
                ]
            )
        }
    }
    
    init(pier: Pier) {
        self.pier = pier
    }
    
    convenience init(url: URL) {
        self.init(pier: Pier(url: url))
    }
    
}

extension Ship {
    
    enum OpenError: Error, LocalizedError {
        
        case shipAlreadyOpen(_ ship: Ship)
        
        var errorDescription: String? {
            switch self {
            case .shipAlreadyOpen(let ship):
                return "A ship with url \"\(ship.url.abbreviatedPath)\" is already opened."
            }
        }
        
    }
    
    func new(bootType: UrbitCommandNew.BootType) throws {
        guard case .stopped = state else {
            return
        }
        
        guard Ship.all.contains(self) == false else {
            throw OpenError.shipAlreadyOpen(self)
        }
        
        state = .started(
            .creating(
                subscriber: UrbitCommandNew(pier: url, bootType: bootType).process.publisher().handleEvents(
                    receiveCancel: {
                        self.state = .stopped(.cancelled)
                    }
                ).sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            self.state = .stopped(.finished)
                        case .failure(let error):
                            self.state = .stopped(.failure(error))
                        }
                    },
                    receiveValue: { message in
                        switch message {
                        case .standardOutput(let data):
                            FileHandle.standardOutput.write(data)
                        case .standardError(let data):
                            FileHandle.standardError.write(data)
                        }
                    }
                )
            )
        )
        
        Ship.all.append(self)
    }
    
    func open() throws {
        guard Ship.all.contains(self) == false else {
            throw OpenError.shipAlreadyOpen(self)
        }
        
        Ship.all.append(self)
    }
    
    func close() {
        Ship.all.removeAll(where: { $0 == self })
    }
    
}

extension Ship {
        
    func start() {
        guard case .stopped = state else {
            return
        }
        
        state = .started(
            .running(
                subscriber: UrbitCommandRun(pier: url).process.publisher().handleEvents(
                    receiveCancel: {
                        self.state = .stopped(.cancelled)
                    }
                ).sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            self.state = .stopped(.finished)
                        case .failure(let error):
                            self.state = .stopped(.failure(error))
                        }
                    },
                    receiveValue: { message in
                        switch message {
                        case .standardOutput(let data):
                            FileHandle.standardOutput.write(data)
                        case .standardError(let data):
                            FileHandle.standardError.write(data)
                        }
                    }
                )
            )
        )
    }
    
    func stop() {
        guard case .started(let state) = state else {
            return
        }
        
        state.subscriber.cancel()
    }
    
}

extension Ship {
    
    var url: URL {
        return pier.url
    }
    
    var name: String {
        return pier.url.lastPathComponent
    }
    
}

extension Ship: Comparable {
    
    static func < (lhs: Ship, rhs: Ship) -> Bool {
        return lhs.name < lhs.name
    }
    
}

extension Ship: Equatable {
    
    static func == (lhs: Ship, rhs: Ship) -> Bool {
        return lhs.url == rhs.url
    }
    
}

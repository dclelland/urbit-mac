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

extension Ship {
    
    static var all: [Ship] = Pier.all.map { Ship(pier: $0) } {
        didSet {
            Pier.all = all.map { $0.pier }
        }
    }
    
}

class Ship {
    
    enum State {
        
        case ready
        case creating(subscriber: AnyCancellable)
        case starting(subscriber: AnyCancellable)
        case started(subscriber: AnyCancellable)
        case stopped(error: Error)
        
        var subscriber: AnyCancellable? {
            switch self {
            case .ready:
                return nil
            case .creating(let subscriber):
                return subscriber
            case .starting(let subscriber):
                return subscriber
            case .started(let subscriber):
                return subscriber
            case .stopped:
                return nil
            }
        }
        
    }
    
    var pier: Pier
    
    var state: State = .ready {
        didSet {
            deliverUserNotification()
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
        #warning("TODO: Check state")
        guard Ship.all.contains(self) == false else {
            throw OpenError.shipAlreadyOpen(self)
        }
        
        state = .starting(
            subscriber: UrbitCommandNew(pier: url, bootType: bootType).process.publisher().sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.state = .ready
                    case .failure(let error):
                        self.state = .stopped(error: error)
                    }
                },
                receiveValue: { message in
                    switch message {
                    case .standardOutput(let message):
                        print(message, terminator: "")
                    case .standardError(let message):
                        print(message, terminator: "")
                    }
                }
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
        #warning("TODO: Check state")
        state = .starting(
            subscriber: UrbitCommandRun(pier: url).process.publisher().sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.state = .ready
                    case .failure(let error):
                        self.state = .stopped(error: error)
                    }
                },
                receiveValue: { message in
                    switch message {
                    case .standardOutput(let message):
                        print(message, terminator: "")
                    case .standardError(let message):
                        print(message, terminator: "")
                    }
                }
            )
        )
    }
    
    func stop() {
        #warning("TODO: Check state")
        state.subscriber?.cancel()
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

extension Ship: UserNotification {
    
    var userNotification: NSUserNotification? {
        switch state {
        case .ready:
            return NSUserNotification(
                title: "Ship is ready: \(url.abbreviatedPath)"
            )
        case .creating:
            return NSUserNotification(
                title: "Ship is being created: \(url.abbreviatedPath)"
            )
        case .starting:
            return NSUserNotification(
                title: "Ship is being started: \(url.abbreviatedPath)"
            )
        case .started:
            return NSUserNotification(
                title: "Ship started: \(url.abbreviatedPath)"
            )
        case .stopped(let error):
            return NSUserNotification(
                title: "Ship stopped: \(url.abbreviatedPath)",
                informativeText: error.localizedDescription
            )
        }
    }
    
}

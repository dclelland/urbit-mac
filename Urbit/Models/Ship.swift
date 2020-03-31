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

struct Ship {
    
    enum State {
        
        case ready
        case creating(process: Process)
        case starting(process: Process)
        case started(process: Process)
        case stopped(process: Process, error: Error)
        
        var process: Process? {
            switch self {
            case .ready:
                return nil
            case .creating(let process):
                return process
            case .starting(let process):
                return process
            case .started(let process):
                return process
            case .stopped(let process, _):
                return process
            }
        }
        
    }
    
    var pier: Pier
    
    var state: State = .ready {
        didSet {
            deliverUserNotification()
        }
    }
    
}

extension Ship: Comparable {
    
    static func < (lhs: Ship, rhs: Ship) -> Bool {
        return lhs.name < lhs.name
    }
    
}

extension Ship: Equatable {
    
    static func == (lhs: Ship, rhs: Ship) -> Bool {
        return lhs.pier.url == rhs.pier.url
    }
    
}

extension Ship: UserNotification {
    
    var userNotification: NSUserNotification? {
        switch state {
        case .ready:
            return NSUserNotification(
                title: "Ship is ready: \(pier.url.abbreviatedPath)"
            )
        case .creating:
            return NSUserNotification(
                title: "Ship is being created: \(pier.url.abbreviatedPath)"
            )
        case .starting:
            return NSUserNotification(
                title: "Ship is being started: \(pier.url.abbreviatedPath)"
            )
        case .started:
            return NSUserNotification(
                title: "Ship started: \(pier.url.abbreviatedPath)"
            )
        case .stopped(_, let error):
            return NSUserNotification(
                title: "Ship stopped: \(pier.url.abbreviatedPath)",
                informativeText: error.localizedDescription
            )
        }
    }
    
}

extension Ship {
    
    var name: String {
        return pier.url.lastPathComponent
    }
    
}

#warning("TODO: Remove these")

private var cancellable: AnyCancellable?

extension Ship {
    
    enum OpenError: Error, LocalizedError {
        
        case shipAlreadyOpen(_ ship: Ship)
        
        var errorDescription: String? {
            switch self {
            case .shipAlreadyOpen(let ship):
                return "A ship with url \"\(ship.pier.url.abbreviatedPath)\" is already opened."
            }
        }
        
    }
    
    func new(bootType: UrbitCommandNew.BootType) {
        cancellable = UrbitCommandNew(pier: pier.url, bootType: bootType).process.publisher().sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("FINISHED")
                case .failure(let error):
                    print("FAILURE", error)
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
    }
    
    func open() throws {
        if Ship.all.contains(self) {
            throw OpenError.shipAlreadyOpen(self)
        } else {
            Ship.all.append(self)
        }
    }
    
    func close() {
        Ship.all.removeAll(where: { $0 == self })
    }
    
}

extension Ship {
        
    func start() {
        cancellable = UrbitCommandRun(pier: pier.url).process.publisher().sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("FINISHED")
                case .failure(let error):
                    print("FAILURE", error)
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
    }
    
    func stop() {
        cancellable?.cancel()
    }
    
}

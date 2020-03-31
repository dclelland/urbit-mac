//
//  Pier.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation
import Combine
import Defaults
import UrbitKit

extension Defaults.Keys {
    
    static let piers = Key<[URL]>("piers", default: [])
    
}

extension Pier {
    
    static var all: [Pier] = Defaults[.piers].map { Pier(url: $0) } {
        didSet {
            Defaults[.piers] = all.map { $0.url }
        }
    }
    
}

struct Pier {
    
    var url: URL
    
    var ship: Ship = .ready {
        didSet {
            ship.deliverUserNotification()
        }
    }
    
}

extension Pier: Comparable {
    
    static func < (lhs: Pier, rhs: Pier) -> Bool {
        return lhs.name < lhs.name
    }
    
}

extension Pier: Equatable {
    
    static func == (lhs: Pier, rhs: Pier) -> Bool {
        return lhs.url == rhs.url
    }
    
}

#warning("TODO: Remove these")

private var cancellable: AnyCancellable?

extension Pier {
    
    enum OpenError: Error, LocalizedError {
        
        case pierAlreadyOpen(_ pier: Pier)
        
        var errorDescription: String? {
            switch self {
            case .pierAlreadyOpen(let pier):
                return "A pier with url \"\(pier.url.abbreviatedPath)\" is already opened."
            }
        }
        
    }
    
    func new(bootType: UrbitCommandNew.BootType) {
        cancellable = UrbitCommandNew(pier: url, bootType: bootType).process.publisher().sink(
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
        if Pier.all.contains(self) {
            throw OpenError.pierAlreadyOpen(self)
        } else {
            Pier.all.append(self)
        }
    }
    
    func close() {
        Pier.all.removeAll(where: { $0 == self })
    }
    
}

extension Pier {
        
    func start() {
        cancellable = UrbitCommandRun(pier: url).process.publisher().sink(
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

extension Pier {
    
    var name: String {
        return url.lastPathComponent
    }
    
}

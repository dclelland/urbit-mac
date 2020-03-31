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
    
    static let piers = Key<[Pier]>("piers", default: [])
    
}

struct Pier {
    
    var url: URL
    
    var ship: Ship = .ready {
        didSet {
            ship.deliverUserNotification()
        }
    }
    
}

extension Pier: Codable {
    
    enum CodingKeys: CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(URL.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
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

extension Pier {
    
    static var all: [Pier] {
        set {
            Defaults[.piers] = newValue
        }
        get {
            return Defaults[.piers]
        }
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
        #warning("TODO: This")
    }
    
    func stop() {
        #warning("TODO: This")
    }
    
}

extension Pier {
    
    var name: String {
        return url.lastPathComponent
    }
    
}

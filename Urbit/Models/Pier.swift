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
import PromiseKit
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
    
    func new(bootType: UrbitCommandNew.BootType) -> ProcessPublisher {
        return UrbitCommandNew(pier: url, bootType: bootType).process.publisher()
    }
    
    func new(bootType: UrbitCommandNew.BootType) -> Promise<Pier> {
        return Promise { resolver in
            cancellable = UrbitCommandNew(pier: url, bootType: bootType).process.publisher().sink(
                receiveCompletion: { completion in
                    print(completion)
                    switch completion {
                    case .finished:
                        resolver.fulfill(self)
                    case .failure(let error):
                        resolver.reject(error)
                    }
                },
                receiveValue: { message in
                    print(message)
                }
            )
        }
    }
    
    func open() -> Promise<Pier> {
        return Promise { resolver in
            if Pier.all.contains(self) {
                resolver.reject(OpenError.pierAlreadyOpen(self))
            } else {
                Pier.all.append(self)
                resolver.fulfill(self)
            }
        }
    }
    
    func close() {
        Pier.all.removeAll(where: { $0 == self })
    }
    
}

extension Pier {
        
    func start() -> Promise<Pier> {
        #warning("TODO: This")
        return Promise.value(self)
    }
    
    func stop() -> Promise<Pier> {
        #warning("TODO: This")
        return Promise.value(self)
    }
    
}

extension Pier {
    
    var name: String {
        return url.lastPathComponent
    }
    
}

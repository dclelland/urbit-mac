//
//  Pier.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation
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

extension Pier {
    
    enum OpenError: Error, LocalizedError {
        
        case pierAlreadyOpen(_ pier: Pier)
        
        var errorDescription: String? {
            switch self {
            case .pierAlreadyOpen(let pier):
                return "A pier with url \"\(pier.url.path)\" is already opened."
            }
        }
        
    }
    
    #warning("This `run` extension should be a Process extension supporting PromiseKit; then Process extension itself should switch from PromiseKit to Combine")
    #warning("Should `new` call `open` on completion?")
    
    func new(bootType: UrbitCommandNew.BootType) -> Promise<Pier> {
        let command = UrbitCommandNew(pier: url, bootType: bootType)
//        command.process.standardOutputPipe = Pipe()
//        command.process.standardOutputPipe?.fileHandleForReading.readabilityHandler = { handle in
//            guard let line = String(bytes: handle.availableData, encoding: .utf8) else {
//                return
//            }
//
//            print("<<<[STDOUT]>>>")
//            print(line)
//        }
//
//        command.process.standardErrorPipe = Pipe()
//        command.process.standardErrorPipe?.fileHandleForReading.readabilityHandler = { handle in
//            guard let line = String(bytes: handle.availableData, encoding: .utf8) else {
//                return
//            }
//
//            print("<<<[STDERR]>>>")
//            print(line)
//        }
        
        return Promise { resolver in
            command.process.run { result in
                switch result {
                case .success(_):
                    resolver.fulfill(self)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
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

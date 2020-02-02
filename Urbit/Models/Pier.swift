//
//  Pier.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation
import Defaults

extension Defaults.Keys {
    
    static let piers = Key<[Pier]>("piers", default: [])
    
}

struct Pier {
    
    var url: URL
    
    var ship: Ship = .ready
    
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
    
    enum OpenError: Error, LocalizedError {
        
        case pierAlreadyOpen(_ pier: Pier)
        
        var errorDescription: String? {
            switch self {
            case .pierAlreadyOpen(let pier):
                return "A pier with url \"\(pier.url.path)\" is already opened."
            }
        }
        
    }
    
    func open() throws {
        guard Pier.all.contains(self) == false else {
            throw OpenError.pierAlreadyOpen(self)
        }
        
        Pier.all.append(self)
    }
    
    func close() {
        Pier.all.removeAll(where: { $0 == self })
    }
    
}

extension Pier {
    
    var name: String {
        return url.lastPathComponent
    }
    
}

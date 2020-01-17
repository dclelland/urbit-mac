//
//  UrbitCommandDebug.swift
//  Urbit
//
//  Created by Daniel Clelland on 13/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

class UrbitCommandDebug: UrbitCommand {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["bug"] + arguments)
    }
    
}

class UrbitCommandDebugValidatePill: UrbitCommandDebug {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["validate-pill"] + arguments)
    }
    
    convenience init(pill: URL, printPill: Bool = false, printBoot: Bool = false) {
        var arguments: [String] = [pill.absoluteString]
        if printPill == true {
            arguments += ["--print-pill"]
        }
        if printBoot == true {
            arguments += ["--print-boot"]
        }
        self.init(arguments: arguments)
    }
    
}

class UrbitCommandDebugCollectAllEffects: UrbitCommandDebug {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["collect-all-fx"] + arguments)
    }
    
    convenience init(pier: URL) {
        self.init(arguments: [pier.absoluteString])
    }
    
}

class UrbitCommandDebugValidateEvents: UrbitCommandDebug {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["validate-events"] + arguments)
    }
    
    convenience init(pier: URL, first: UInt64? = nil, last: UInt64? = nil) {
        var arguments: [String] = [pier.absoluteString]
        if let first = first {
            arguments += ["--first", String(first)]
        }
        if let last = last {
            arguments += ["--last", String(last)]
        }
        self.init(arguments: arguments)
    }
    
}

class UrbitCommandDebugEventBrowser: UrbitCommandDebug {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["event-browser"] + arguments)
    }
    
    convenience init(pier: URL) {
        self.init(arguments: [pier.absoluteString])
    }
    
}

class UrbitCommandDebugValidateEffects: UrbitCommandDebug {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["validate-effects"] + arguments)
    }
    
    convenience init(pier: URL, first: UInt64? = nil, last: UInt64? = nil) {
        var arguments: [String] = [pier.absoluteString]
        if let first = first {
            arguments += ["--first", String(first)]
        }
        if let last = last {
            arguments += ["--last", String(last)]
        }
        self.init(arguments: arguments)
    }
    
}

class UrbitCommandDebugCheckDawn: UrbitCommandDebug {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["dawn"] + arguments)
    }
    
    convenience init(keyfile: URL) {
        self.init(arguments: [keyfile.absoluteString])
    }
    
}

class UrbitCommandDebugCheckComet: UrbitCommandDebug {
    
    required init(arguments: [String] = []) {
        super.init(arguments: ["comet"])
    }
    
}

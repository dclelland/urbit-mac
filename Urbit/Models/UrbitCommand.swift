//
//  UrbitProcessCommand.swift
//  Urbit
//
//  Created by Daniel Clelland on 11/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

protocol UrbitCommand: CustomStringConvertible {
    
    var arguments: [String] { get }
    
}

extension UrbitCommand {
    
    var description: String {
        return arguments.joined(separator: " ")
    }
    
}

//enum UrbitCommand: CustomStringConvertible {
//
//    case new(UrbitCommandNew, options: [UrbitCommandOption] = [])
//    case run(UrbitCommandRun, options: [UrbitCommandOption] = [])
//    case debug(UrbitCommandDebug)
//    case connect(UrbitCommandConnect)
//
//    var description: String {
//        switch self {
//        case .new(let new, let options):
//            var arguments = "new \(new)"
//            for option in options {
//                arguments.append(contentsOf: " \(option)")
//            }
//            return arguments
//        case .run(let run, let options):
//            var arguments = "run \(run)"
//            for option in options {
//                arguments.append(contentsOf: " \(option)")
//            }
//            return arguments
//        case .debug(let debug):
//            return "bug \(debug)"
//        case .connect(let pier):
//            return "con \(pier)"
//        }
//    }
//
//}

struct UrbitCommandNew: UrbitCommand {
    
    enum BootType: UrbitCommand {
        
        case newComet
        case newFakeship(ship: String)
        case newFromKeyfile(keyfile: URL)
        
        var arguments: [String] {
            switch self {
            case .newComet:
                return ["--comet"]
            case .newFakeship(let ship):
                return ["--fake", ship]
            case .newFromKeyfile(let keyfile):
                return ["--keyfile", keyfile.absoluteString]
            }
        }
        
    }
    
    var pill: URL
    var pier: URL? = nil
    var arvo: URL? = nil
    var bootType: BootType
    var lite: Bool = false
    var options: [UrbitCommandOption] = []
    
//    new :: Parser New
//    new = do
//        nPierPath <- optional pierPath
//
//        nBootType <- newComet <|> newFakeship <|> newFromKeyfile
//
//        nPillSource <- pillFromPath <|> pillFromURL
//
//        nLite <- switch
//                   $ short 'l'
//                  <> long "lite"
//                  <> help "Boots ship in lite mode"
//
//        nArvoDir <- option auto
//                        $ metavar "PATH"
//                       <> short 'A'
//                       <> long "arvo"
//                       <> value Nothing
//                       <> help "Replace initial clay filesys with contents of PATH"
//
//        pure New{..}
    
//    data BootType
//      = BootComet
//      | BootFake Text
//      | BootFromKeyfile FilePath
//      deriving (Show)
//
//    data PillSource
//      = PillSourceFile FilePath
//      | PillSourceURL String
//      deriving (Show)
//
//    data New = New
//        { nPillSource :: PillSource
//        , nPierPath   :: Maybe FilePath -- Derived from ship name if not specified.
//        , nArvoDir    :: Maybe FilePath
//        , nBootType   :: BootType
//        , nLite       :: Bool
//        }
//      deriving (Show)
    
    var arguments: [String] {
        var arguments = ["new"]
        
        #warning("TODO: Finish UrbitProcessCommandNew")
        
        for option in options {
            arguments.append(contentsOf: option.arguments)
        }
        return arguments
    }
    
}

struct UrbitCommandRun: UrbitCommand {
    
    var pier: URL
    var options: [UrbitCommandOption] = []
    
    var arguments: [String] {
        var arguments = ["run", pier.absoluteString]
        for option in options {
            arguments.append(contentsOf: option.arguments)
        }
        return arguments
    }
    
}

enum UrbitCommandDebug: UrbitCommand {
    
    case validatePill(pill: URL, printPill: Bool = false, printBoot: Bool = false)
    case collectAllEffects(pier: URL)
    case eventBrowser(pier: URL)
    case validateEvents(pier: URL, first: UInt64? = nil, last: UInt64? = nil)
    case validateEffects(pier: URL, first: UInt64? = nil, last: UInt64? = nil)
    case checkDawn(keyfile: URL)
    case checkComet
    
    var arguments: [String] {
        var arguments = ["bug"]
        switch self {
        case .validatePill(let pill, let printPill, let printBoot):
            arguments.append(contentsOf: ["validate-pill", pill.absoluteString])
            if printPill == true {
                arguments.append(contentsOf: ["--print-pill"])
            }
            if printBoot == true {
                arguments.append(contentsOf: ["--print-boot"])
            }
        case .collectAllEffects(let pier):
            arguments.append(contentsOf: ["collect-all-fx", pier.absoluteString])
        case .eventBrowser(let pier):
            arguments.append(contentsOf: ["validate-events", pier.absoluteString])
        case .validateEvents(let pier, let first, let last):
            arguments.append(contentsOf: ["event-browser", pier.absoluteString])
            if let first = first {
                arguments.append(contentsOf: ["--first", String(first)])
            }
            if let last = last {
                arguments.append(contentsOf: ["--last", String(last)])
            }
        case .validateEffects(let pier, let first, let last):
            arguments.append(contentsOf: ["validate-effects", pier.absoluteString])
            if let first = first {
                arguments.append(contentsOf: ["--first", String(first)])
            }
            if let last = last {
                arguments.append(contentsOf: ["--last", String(last)])
            }
        case .checkDawn(let keyfile):
            arguments.append(contentsOf: ["dawn", keyfile.absoluteString])
        case .checkComet:
            arguments.append(contentsOf: ["comet"])
        }
        return arguments
    }
    
}

struct UrbitCommandConnect: UrbitCommand {
    
    var pier: URL
    
    var arguments: [String] {
        return ["con", pier.absoluteString]
    }
    
}

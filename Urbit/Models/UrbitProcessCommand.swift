//
//  UrbitProcessCommand.swift
//  Urbit
//
//  Created by Daniel Clelland on 11/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

enum UrbitProcessCommand: CustomStringConvertible {
    
    case new(UrbitProcessCommandNew, options: [UrbitProcessOption] = [])
    case run(UrbitProcessCommandRun, options: [UrbitProcessOption] = [])
    case debug(UrbitProcessCommandDebug)
    case connect(UrbitProcessCommandConnect)
    
    var description: String {
        switch self {
        case .new(let new, let options):
            var arguments = "new \(new)"
            for option in options {
                arguments.append(contentsOf: " \(option)")
            }
            return arguments
        case .run(let run, let options):
            var arguments = "run \(run)"
            for option in options {
                arguments.append(contentsOf: " \(option)")
            }
            return arguments
        case .debug(let debug):
            return "bug \(debug)"
        case .connect(let pier):
            return "con \(pier)"
        }
    }
    
}

struct UrbitProcessCommandNew: CustomStringConvertible {
    
    #warning("TODO: Finish UrbitProcessCommandNew")
    
    enum BootType: CustomStringConvertible {
        
        case newComet
        case newFakeship(ship: String)
        case newFromKeyfile(keyfile: URL)
        
        var description: String {
            switch self {
            case .newComet:
                return "--comet"
            case .newFakeship(let ship):
                return "--fake \(ship)"
            case .newFromKeyfile(let keyfile):
                return "--keyfile \(keyfile)"
            }
        }
        
    }
    
    var pill: URL
    var pier: URL? = nil
    var arvo: URL? = nil
    var bootType: BootType
    var lite: Bool = false
    
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
    
    var description: String {
        fatalError()
    }
    
}

struct UrbitProcessCommandRun: CustomStringConvertible {
    
    var pier: URL
    
    var description: String {
        return "\(pier)"
    }
    
}

enum UrbitProcessCommandDebug: CustomStringConvertible {
    
    case validatePill(pill: URL, printPill: Bool = false, printBoot: Bool = false)
    case collectAllEffects(pier: URL)
    case eventBrowser(pier: URL)
    case validateEvents(pier: URL, first: UInt64? = nil, last: UInt64? = nil)
    case validateEffects(pier: URL, first: UInt64? = nil, last: UInt64? = nil)
    case checkDawn(keyfile: URL)
    case checkComet
    
    var description: String {
        switch self {
        case .validatePill(let pill, let printPill, let printBoot):
            var arguments = "validate-pill \(pill)"
            if printPill == true {
                arguments.append(contentsOf: " --print-pill")
            }
            if printBoot == true {
                arguments.append(contentsOf: " --print-boot")
            }
            return arguments
        case .collectAllEffects(let pier):
            return "collect-all-fx \(pier)"
        case .eventBrowser(let pier):
            return "validate-events \(pier)"
        case .validateEvents(let pier, let first, let last):
            var arguments = "event-browser \(pier)"
            if let first = first {
                arguments.append(contentsOf: " --first \(first)")
            }
            if let last = last {
                arguments.append(contentsOf: " --last \(last)")
            }
            return arguments
        case .validateEffects(let pier, let first, let last):
            var arguments = "validate-effects \(pier)"
            if let first = first {
                arguments.append(contentsOf: " --first \(first)")
            }
            if let last = last {
                arguments.append(contentsOf: " --last \(last)")
            }
            return arguments
        case .checkDawn(let keyfile):
            return "dawn \(keyfile)"
        case .checkComet:
            return "comet"
        }
    }
    
}

struct UrbitProcessCommandConnect: CustomStringConvertible {
    
    var pier: URL
    
    var description: String {
        return "\(pier)"
    }
    
}

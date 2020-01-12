//
//  UrbitProcessArguments.swift
//  Urbit
//
//  Created by Daniel Clelland on 11/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import Foundation

enum UrbitProcessArguments: CustomStringConvertible {
    
    case new(UrbitProcessArgumentsNew, options: [UrbitProcessOption] = [])
    case run(UrbitProcessArgumentsRun, options: [UrbitProcessOption] = [])
    case debug(UrbitProcessArgumentsDebug)
    case connect(UrbitProcessArgumentsConnect)
    
    var description: String {
        switch self {
        case .new(let new, let options):
            return "new \(new) \(options.map({ $0.description }).joined(separator: " "))"
        case .run(let run, let options):
            return "run \(run) \(options.map({ $0.description }).joined(separator: " "))"
        case .debug(let debug):
            return "bug \(debug)"
        case .connect(let pier):
            return "con \(pier)"
        }
    }
    
}

struct UrbitProcessArgumentsNew: CustomStringConvertible {
    
    #warning("TODO: Finish UrbitProcessArgumentsNew")
    
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

struct UrbitProcessArgumentsRun: CustomStringConvertible {
    
    var pier: URL
    
    var description: String {
        return "\(pier)"
    }
    
}

enum UrbitProcessArgumentsDebug: CustomStringConvertible {
    
    #warning("TODO: Finish UrbitProcessArgumentsDebug")
    
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
            return "validate-pill \(pill)"
        case .collectAllEffects(let pier):
            return "collect-all-fx \(pier)"
        case .eventBrowser(let pier):
            return "validate-events \(pier)"
        case .validateEvents(let pier, let first, let last):
            return "event-browser \(pier)"
        case .validateEffects(let pier, let first, let last):
            return "validate-effects \(pier)"
        case .checkDawn(let keyfile):
            return "dawn \(keyfile)"
        case .checkComet:
            return "comet"
        }
    }
    
}

struct UrbitProcessArgumentsConnect: CustomStringConvertible {
    
    var pier: URL
    
    var description: String {
        return "\(pier)"
    }
    
}

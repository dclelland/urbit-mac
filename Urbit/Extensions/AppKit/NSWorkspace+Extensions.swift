//
//  NSWorkspace+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 24/01/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

extension NSWorkspace {
    
    func openInFinder(_ url: URL) {
        activateFileViewerSelecting([url])
    }
    
    func openInBrowser(_ url: URL) {
        open(url)
    }
    
    func openInTerminal(_ url: URL) {

//        """Run a shell command in a new Terminal.app window."""
//        termAddress = AE.AECreateDesc(typeApplicationBundleID, "com.apple.Terminal")
//        theEvent = AE.AECreateAppleEvent(kAECoreSuite, kAEDoScript, termAddress,
//                                         kAutoGenerateReturnID, kAnyTransactionID)
//        commandDesc = AE.AECreateDesc(typeChar, command)
//        theEvent.AEPutParamDesc(kAECommandClass, commandDesc)
//
//        try:
//            theEvent.AESend(SEND_MODE, kAENormalPriority, kAEDefaultTimeout)
//        except AE.Error, why:
//            if why[0] != -600:  # Terminal.app not yet running
//                raise
//            os.system(START_TERMINAL)
//            time.sleep(1)
//            theEvent.AESend(SEND_MODE, kAENormalPriority, kAEDefaultTimeout)

        let eventDescriptor = NSAppleEventDescriptor(
            eventClass: AEEventClass(kAECoreSuite),
            eventID: AEEventID(kAEDoScript),
            targetDescriptor: NSAppleEventDescriptor(bundleIdentifier: "com.apple.Terminal"),
            returnID: AEReturnID(kAutoGenerateReturnID),
            transactionID: AETransactionID(kAnyTransactionID)
        )
        
        let commandDescriptor = NSAppleEventDescriptor(string: "say fart")
        
        eventDescriptor.setParam(commandDescriptor, forKeyword: kAECommandClass)
        
        do {
            try eventDescriptor.sendEvent(options: .defaultOptions, timeout: TimeInterval(kAEDefaultTimeout))
        } catch let error {
            print(error)
        }
        
//        NSWorkspace.shared.open([pier.url], withAppBundleIdentifier: "com.apple.Terminal", options: .withErrorPresentation, additionalEventParamDescriptor: eventDescriptor, launchIdentifiers: nil)
        
//        #warning("Need to pass binary URL and arguments")
//        let command = UrbitCommandConnect(pier: pier.url)
//        print(command.process.executableURL!.path, command.process.arguments!)
    }
    
}

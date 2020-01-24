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
    
    func openInTerminal(_ url: URL, script: String) {
        let source = """
        if application "Terminal" is running then
            tell application "Terminal"
                do script "cd \(url.path); \(script)"
                activate
            end tell
        else
            tell application "Terminal"
                do script "cd \(url.path); \(script)" in front window
                activate
            end tell
        end if
        """
        NSAppleScript(source: source)?.executeAndReturnError(nil)
    }
    
}

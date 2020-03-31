//
//  NSAlert+Extensions.swift
//  Urbit
//
//  Created by Daniel Clelland on 3/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit
import Combine

extension NSAlert {
    
    convenience init(style: NSAlert.Style = .informational, messageText: String = "", informativeText: String = "") {
        self.init()
        self.alertStyle = style
        self.messageText = messageText
        self.informativeText = informativeText
    }
    
}

extension NSAlert {
    
    struct Text {
        
        var message: String
        var information: String
        
        init(message: String = "", information: String = "") {
            self.message = message
            self.information = information
        }
        
    }
    
    convenience init(style: NSAlert.Style = .informational, text: Text) {
        self.init()
        self.alertStyle = style
        self.messageText = text.message
        self.informativeText = text.information
    }
    
}

extension NSAlert {
    
    struct Button {
        
        var title: String
        
        init(title: String = "") {
            self.title = title
        }
        
    }
    
    convenience init(style: NSAlert.Style = .informational, text: Text, button: Button) {
        self.init(style: style, text: text)
        self.addButton(withTitle: button.title)
        self.addButton(withTitle: "Cancel")
    }
    
}

extension NSAlert {
    
    struct TextField {
        
        var text: String
        var placeholder: String
        
        init(text: String = "", placeholder: String = "") {
            self.text = text
            self.placeholder = placeholder
        }
        
    }
    
    convenience init(style: NSAlert.Style = .informational, text: Text, textField: TextField, button: Button) {
        self.init(style: style, text: text, button: button)
        self.textField = NSTextField(frame: NSRect(x: 0.0, y: 0.0, width: 240.0, height: 22.0))
        self.textField?.stringValue = textField.text
        self.textField?.placeholderString = textField.placeholder
    }
    
    var textField: NSTextField? {
        get {
            return accessoryView as? NSTextField
        }
        set {
            accessoryView = newValue
        }
    }
    
}

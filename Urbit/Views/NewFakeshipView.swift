//
//  NewFakeshipView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

class URLFormatter: Formatter {
    
    let directory: Bool = false
    
    override func string(for object: Any?) -> String? {
        return (object as? URL)?.path
    }
    
    override func getObjectValue(_ object: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        object?.pointee = URL(fileURLWithPath: string, isDirectory: directory) as AnyObject
        return true
    }
    
}

struct NewFakeshipView: View {
    
    @State private var name: String = "zod"
    
    @State private var url: URL = URL(fileURLWithPath: "~", isDirectory: true)
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("URL", value: $url, formatter: URLFormatter())
            }
            Section {
                Button(
                    action: {
                        // Create fakeship
                    }
                ) {
                    Text("Create Fakeship")
                }
                .frame(alignment: .leading)
            }
        }
        .padding()
        .frame(width: 400.0)
    }
    
//    NSAlert.textField(
//        text: .init(
//            message: "Fakeship name"
//        ),
//        textField: .init(
//            placeholder: "zod"
//        ),
//        button: .init(
//            title: "Save"
//        )
//    ).then { name in
//        return NSSavePanel.save(
//            title: "New Fakeship",
//            fileName: name
//        ).then { url -> Promise<Pier> in
//            return Pier(url: url).new(bootType: .newFakeship(name))
//        }
//    }.catch { error in
//        NSAlert(error: error).runModal()
//    }
    
}

struct NewFakeshipView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewFakeshipView()
    }
    
}

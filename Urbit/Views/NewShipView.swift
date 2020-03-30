//
//  NewShipView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewShipView: View {
    
    @State private var keyfileURL: URL = URL(fileURLWithPath: "/~", isDirectory: true)
    
    @State private var url: URL = URL(fileURLWithPath: "/~", isDirectory: true)
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .firstTextBaseline) {
                Text("Keyfile:")
                    .frame(minWidth: 80.0, alignment: .trailing)
                TextField("/~", value: $keyfileURL, formatter: URLFormatter())
            }
            HStack(alignment: .firstTextBaseline) {
                Text("Directory:")
                    .frame(minWidth: 80.0, alignment: .trailing)
                TextField("/~", value: $url, formatter: URLFormatter(directory: true))
            }
            Divider()
            HStack {
                Button(
                    action: {
                        // Create fakeship
                    }
                ) {
                    Text("Create Fakeship")
                }
            }
        }
        .padding()
        .frame(width: 400.0)
    }
    
//    NSOpenPanel.open(
//        title: "Open Keyfile",
//        fileTypes: ["key"]
//    ).then { keyfile -> Promise<Pier> in
//        return NSSavePanel.save(
//            title: "New Ship",
//            fileName: keyfile.lastPathComponent.fileName
//        ).then { url in
//            return Pier(url: url).new(bootType: .newFromKeyfile(keyfile))
//        }
//    }.catch { error in
//        NSAlert(error: error).runModal()
//    }
    
}

struct NewShipView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewShipView()
    }
    
}

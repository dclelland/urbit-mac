//
//  NewFakeshipView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewFakeshipView: View {
    
    @State private var name: String = "zod"
    
    @State private var url: URL = URL(fileURLWithPath: "/~", isDirectory: true)
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .firstTextBaseline) {
                Text("Name:")
                    .frame(minWidth: 80.0, alignment: .trailing)
                TextField("zod", text: $name)
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

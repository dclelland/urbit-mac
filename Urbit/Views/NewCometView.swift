//
//  NewCometView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewCometView: View {
    
    @State private var url: URL = URL(fileURLWithPath: "/~", isDirectory: true)
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .firstTextBaseline) {
                Text("Directory:").frame(minWidth: 80.0, alignment: .trailing)
                TextField("/~", value: $url, formatter: URLFormatter(directory: true))
            }
            Divider()
            HStack {
                Button(
                    action: {
                        // Create comet
                    }
                ) {
                    Text("Create Comet")
                }
            }
        }
        .padding()
        .frame(width: 400.0)
    }
    
//    NSSavePanel.save(
//        title: "New Comet"
//    ).then { url -> Promise<Pier> in
//        return Pier(url: url).new(bootType: .newComet)
//    }.catch { error in
//        NSAlert(error: error).runModal()
//    }
    
}

struct NewCometView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewCometView()
    }
    
}

//
//  NewShipView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewShipView: View {
    
    var body: some View {
        Text("New Ship View")
            .frame(width: 400.0, height: 200.0)
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

//
//  NewFakeshipView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewFakeshipView: View {
    
    var body: some View {
        Text("New Fakeship View")
            .frame(width: 400.0, height: 200.0)
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
        NewShipView()
    }
    
}

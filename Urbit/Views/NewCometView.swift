//
//  NewCometView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewCometView: View {
    
    var body: some View {
        Text("New Comet View")
            .frame(width: 400.0, height: 200.0)
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
        NewShipView()
    }
    
}

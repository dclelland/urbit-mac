//
//  NewCometView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewCometView: View {
    
    @State private var url: URL? = nil
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .firstTextBaseline) {
                Text("Directory:")
                    .frame(minWidth: 80.0, alignment: .trailing)
//                PathControl(pathStyle: .popUp, url: $url)
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

struct PathControl: NSViewRepresentable {
    
    var isEditable: Bool = true
    
    var allowedTypes: [String]? = nil
    
    var placeholderString: String? = nil
    
    var pathStyle: NSPathControl.Style = .standard
    
    @Binding var url: URL?
    
    @Binding var clickedPathItem: NSPathControlItem?
    
    func makeNSView(context: NSViewRepresentableContext<PathControl>) -> NSPathControl {
        let pathControl = NSPathControl()
        pathControl.isEditable = isEditable
        pathControl.allowedTypes = allowedTypes
        pathControl.placeholderString = placeholderString
        pathControl.pathStyle = pathStyle
        pathControl.target = context.coordinator
        pathControl.action = #selector(Coordinator.updateURL(_:))
        return pathControl
    }
    
    func updateNSView(_ nsView: NSPathControl, context: NSViewRepresentableContext<PathControl>) {
        nsView.url = url
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSPathControlDelegate {
        
        var pathControl: PathControl

        init(_ pathControl: PathControl) {
            self.pathControl = pathControl
        }

        @objc func updateURL(_ sender: NSPathControl) {
            pathControl.url = sender.url
            pathControl.clickedPathItem = sender.clickedPathItem
        }
        
    }
    
}

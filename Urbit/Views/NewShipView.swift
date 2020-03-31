//
//  NewShipView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewShipView: View {
    
    @State private var keyfileURL: URL? = nil
    
    @State private var directoryURL: URL? = nil
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Keyfile:")
                    .frame(minWidth: 80.0, alignment: .trailing)
                TextField("", value: $keyfileURL, formatter: URLFormatter())
                    .disabled(true)
                    .foregroundColor(.secondary)
                Button(action: openKeyfileURL) {
                    Text("Open...")
                }
            }
            HStack {
                Text("Directory:")
                    .frame(minWidth: 80.0, alignment: .trailing)
                TextField("", value: $directoryURL, formatter: URLFormatter(directory: true))
                    .disabled(true)
                    .foregroundColor(.secondary)
                Button(action: openDirectoryURL) {
                    Text("Open...")
                }
            }
            Divider()
            HStack {
                Button(action: createShip) {
                    Text("Create Ship")
                }
            }
        }
        .padding()
        .frame(minWidth: 480.0)
    }
    
    func openKeyfileURL() {
        NSOpenPanel.open(title: "Open Keyfile", fileTypes: ["key"], canChooseDirectories: false).done { url in
            self.keyfileURL = url
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    func openDirectoryURL() {
        NSSavePanel.save(title: "Open Directory", fileName: directoryURL?.lastPathComponent.fileName ?? keyfileURL?.lastPathComponent.fileName ?? "").done { url in
            self.directoryURL = url
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    func createShip() {
//        Pier(url: directoryURL).new(bootType: .newFromKeyfile(keyfile)).catch { error in
//            NSAlert(error: error).runModal()
//        }
    }
    
}

struct NewShipView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewShipView()
    }
    
}

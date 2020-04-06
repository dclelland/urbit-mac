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
    
    var create: (_ url: URL, _ keyfileURL: URL) throws -> Void
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Keyfile:")
                    .frame(minWidth: 80.0, alignment: .trailing)
                TextField("", value: $keyfileURL, formatter: URLFormatter())
                    .disabled(true)
                    .foregroundColor(.secondary)
                Button("Open...", action: openKeyfileURL)
            }
            HStack {
                Text("Directory:")
                    .frame(minWidth: 80.0, alignment: .trailing)
                TextField("", value: $directoryURL, formatter: URLFormatter(directory: true))
                    .disabled(true)
                    .foregroundColor(.secondary)
                Button("Open...", action: openDirectoryURL)
            }
            Divider()
            HStack {
                Button("Create Ship", action: createShip)
                    .disabled(keyfileURL == nil || directoryURL == nil)
            }
        }
        .padding()
        .frame(minWidth: 480.0)
    }
    
    private var fileName: String {
        return directoryURL?.lastPathComponent.fileName ?? keyfileURL?.lastPathComponent.fileName ?? ""
    }
    
    private func openKeyfileURL() {
        NSOpenPanel(title: "Open Keyfile", fileTypes: ["key"], canChooseDirectories: false).begin { url in
            self.keyfileURL = url
        }
    }
    
    private func openDirectoryURL() {
        NSSavePanel(title: "Open Directory", fileName: fileName).begin { url in
            self.directoryURL = url
        }
    }
    
    private func createShip() {
        guard let url = directoryURL, let keyfileURL = keyfileURL else {
            return
        }
        
        do {
            try create(url, keyfileURL)
        } catch let error {
            NSAlert(error: error).runModal()
        }
    }
    
}

struct NewShipView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewShipView(create: { _, _ in })
    }
    
}

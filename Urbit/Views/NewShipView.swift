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
    
    var create: (_ url: URL, _ keyfileURL: URL) -> Void
    
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
        _ = NSOpenPanel.open(title: "Open Keyfile", fileTypes: ["key"], canChooseDirectories: false).done { url in
            self.keyfileURL = url
        }
    }
    
    private func openDirectoryURL() {
        _ = NSSavePanel.save(title: "Open Directory", fileName: fileName).done { url in
            self.directoryURL = url
        }
    }
    
    private func createShip() {
        guard let url = directoryURL, let keyfileURL = keyfileURL else {
            return
        }
        
        create(url, keyfileURL)
    }
    
}

struct NewShipView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewShipView(create: { _, _ in })
    }
    
}

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
    
    @State private var directoryURL: URL? = nil
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Name:")
                    .frame(minWidth: 80.0, alignment: .trailing)
                TextField("zod", text: $name)
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
                Button(action: createFakeship) {
                    Text("Create Fakeship")
                }
                .disabled(directoryURL == nil)
            }
        }
        .padding()
        .frame(minWidth: 480.0)
    }
    
    private var fileName: String {
        return directoryURL?.lastPathComponent.fileName ?? name
    }
    
    private func openDirectoryURL() {
        NSSavePanel.save(title: "Open Directory", fileName: fileName).done { url in
            self.directoryURL = url
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
        
    private func createFakeship() {
//        Pier(url: directoryURL).new(bootType: .newFakeship(name)).catch { error in
//            NSAlert(error: error).runModal()
//        }
    }
    
}

struct NewFakeshipView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewFakeshipView()
    }
    
}

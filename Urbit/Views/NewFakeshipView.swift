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
    
    var create: (_ name: String, _ url: URL) throws -> Void
    
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
                Button("Open...", action: openDirectoryURL)
            }
            Divider()
            HStack {
                Button("Create Fakeship", action: createFakeship)
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
        NSSavePanel(title: "Open Directory", fileName: fileName).begin { url in
            self.directoryURL = url
        }
    }
        
    private func createFakeship() {
        guard let url = directoryURL else {
            return
        }
        
        do {
            try create(name, url)
        } catch let error {
            NSAlert(error: error).runModal()
        }
    }
    
}

struct NewFakeshipView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewFakeshipView(create: { _, _ in })
    }
    
}

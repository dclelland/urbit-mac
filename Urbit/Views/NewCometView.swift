//
//  NewCometView.swift
//  Urbit
//
//  Created by Daniel Clelland on 14/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import SwiftUI

struct NewCometView: View {
    
    @State private var directoryURL: URL? = nil
    
    var create: (_ url: URL) throws -> Void
    
    var body: some View {
        VStack(alignment: .trailing) {
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
                Button("Create Comet", action: createComet)
                    .disabled(directoryURL == nil)
            }
        }
        .padding()
        .frame(minWidth: 480.0)
    }
    
    private var fileName: String {
        return directoryURL?.lastPathComponent.fileName ?? ""
    }
    
    private func openDirectoryURL() {
        NSSavePanel(title: "Open Directory", fileName: fileName).begin { url in
            self.directoryURL = url
        }
    }
            
    private func createComet() {
        guard let url = directoryURL else {
            return
        }
        
        do {
            try create(url)
        } catch let error {
            NSAlert(error: error).runModal()
        }
    }
    
}

struct NewCometView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewCometView(create: { _ in })
    }
    
}

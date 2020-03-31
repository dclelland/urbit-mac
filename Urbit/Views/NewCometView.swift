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
    
    var body: some View {
        VStack(alignment: .trailing) {
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
                Button(action: createComet) {
                    Text("Create Comet")
                }
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
        NSSavePanel.save(title: "Open Directory", fileName: fileName).done { url in
            self.directoryURL = url
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
            
    private func createComet() {
//        Pier(url: directoryURL).new(bootType: .newComet).catch { error in
//            NSAlert(error: error).runModal()
//        }
    }
    
}

struct NewCometView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewCometView()
    }
    
}

//
//  AlertPreview.swift
//  CustomAlert
//
//  Created by David Walter on 17.08.25.
//

import SwiftUI

#if DEBUG
@available(iOS 16.0, *)
struct AlertPreview: View {
    @State private var showNativeAlert = false
    @State private var showCustomAlert = false

    let title: String
    let content: String

    init(title: String, content: String) {
        self.title = title
        self.content = content
    }

    var body: some View {
        List {
            SwiftUI.Button("Show Native Alert") {
                showNativeAlert = true
            }
            SwiftUI.Button("Show Custom Alert") {
                showCustomAlert = true
            }
        }
        .task {
            #if CUSTOM_ALERT_DESIGN
            do {
                showNativeAlert = true
                try await Task.sleep(for: .seconds(1))
                showCustomAlert = true
            } catch {
                print(error.localizedDescription)
            }
            #endif
        }
        .alert(title, isPresented: $showNativeAlert) {
            SwiftUI.Button(role: .cancel) {
            } label: {
                Text("Cancel")
            }
            SwiftUI.Button {
            } label: {
                Text("OK")
            }
        } message: {
            Text(content)
        }
        .customAlert(title, isPresented: $showCustomAlert) {
            Text(content)
        } actions: {
            MultiButton {
                Button(role: .cancel) {
                } label: {
                    Text("Cancel")
                }
                Button {
                } label: {
                    Text("OK")
                }
            }
        }
    }
}
#endif

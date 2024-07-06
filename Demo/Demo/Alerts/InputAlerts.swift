//
//  InputAlerts.swift
//  Demo
//
//  Created by David Walter on 31.12.22.
//

import SwiftUI
import CustomAlert

struct InputAlerts: View {
    @State private var showTextField = false
    @State private var text = ""
    
    var body: some View {
        Section {
            Button {
                showTextField = true
            } label: {
                DetailLabel("TextField", detail: "CustomAlert with a TextField")
            }
            .customAlert("TextField", isPresented: $showTextField) {
                TextField("Enter some String", text: $text)
                    .font(.body)
                    .padding(4)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .systemBackground))
                    }
            } actions: {
                Button(role: .cancel) {
                    print("Input.TextField - Cancel")
                } label: {
                    Text("Cancel")
                }
            }
        } header: {
            Text("Input")
        }
    }
}

#Preview {
    List {
        InputAlerts()
    }
}

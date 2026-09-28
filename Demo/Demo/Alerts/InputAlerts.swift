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
    @State private var showTextEditor = false
    @State private var editorText = ""

    var body: some View {
        Section {
            Button {
                showTextField = true
            } label: {
                DetailLabel("TextField", detail: "CustomAlert with a TextField")
            }
            .customAlert("TextField", isPresented: $showTextField) {
                MyInputAlert(text: $text)
            } actions: {
                Button(role: .cancel) {
                    print("Input.TextField - Cancel")
                } label: {
                    Text("Cancel")
                }
            }
            
            Button {
                showTextEditor = true
            } label: {
                DetailLabel("TextEditor", detail: "CustomAlert with a TextEditor")
            }
            .customAlert("TextEditor", isPresented: $showTextEditor) {
                TextEditor(text: $editorText)
                    .font(.body)
                    .padding(4)
                    .frame(height: 100)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .systemBackground))
                    }
            } actions: {
                Button(role: .cancel) {
                    print("Input.TextEditor - Cancel")
                } label: {
                    Text("Cancel")
                }
            }
        } header: {
            Text("Input")
        }
    }
}

private struct MyInputAlert: View {
    @Binding var text: String

    @FocusState private var isFocused

    var body: some View {
        TextField("Enter some String", text: $text)
            .focused($isFocused)
            .font(.body)
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(uiColor: .systemBackground))
            }
            .onAppear {
                isFocused = true
            }
    }
}

#Preview {
    List {
        InputAlerts()
    }
}

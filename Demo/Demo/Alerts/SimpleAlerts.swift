//
//  SimpleAlerts.swift
//  Demo
//
//  Created by David Walter on 31.12.22.
//

import SwiftUI
import CustomAlert

struct SimpleAlerts: View {
    @State private var showNative = false
    @State private var showCustom = false
    
    var body: some View {
        Section {
            Button {
                showNative = true
            } label: {
                DetailLabel("Native", detail: "SwiftUI native alert")
            }
            .alert("Native Alert", isPresented: $showNative) {
                Button {
                    print("Simple.Native - OK")
                } label: {
                    Text("OK")
                }
                Button(role: .cancel) {
                    print("Simple.Native - Cancel")
                } label: {
                    Text("Cancel")
                }
            } message: {
                Text("Some Message")
            }
            
            Button {
                showCustom = true
            } label: {
                DetailLabel("Custom", detail: "CustomAlert looking like native alert")
            }
            .customAlert("Custom Alert", isPresented: $showCustom) {
                Text("Some Message")
            } actions: {
                MultiButton {
                    Button(role: .cancel) {
                        print("Simple.Custom - Cancel")
                    } label: {
                        Text("Cancel")
                    }
                    Button {
                        print("Simple.Custom - OK")
                    } label: {
                        Text("OK")
                    }
                }
            }
        } header: {
            Text("Simple")
        }
    }
}

#Preview {
    List {
        SimpleAlerts()
    }
}

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
                Text("Native Alert")
            }
            .alert("Native Alert", isPresented: $showNative) {
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
            } message: {
                Text("Some Message")
            }
            
            Button {
                showCustom = true
            } label: {
                Text("Custom Alert")
            }
            .customAlert("Custom Alert", isPresented: $showCustom) {
                Text("Some Message")
            } actions: {
                Button(role: .cancel) {
                    print("Cancel")
                } label: {
                    Text("Cancel")
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

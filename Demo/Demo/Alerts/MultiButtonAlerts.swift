//
//  MultiButtonAlerts.swift
//  Demo
//
//  Created by David Walter on 31.12.22.
//

import SwiftUI
import CustomAlert

struct MultiButtonAlerts: View {
    @State private var showSimple = false
    @State private var showComplex = false
    
    var body: some View {
        Section {
            Button {
                showSimple = true
            } label: {
                DetailLabel("Simple", detail: "CustomAlert using MultiButton with a simple layout")
            }
            .customAlert("Multibutton Alert", isPresented: $showSimple) {
                Text("Simple MultiButton")
            } actions: {
                MultiButton {
                    Button {
                        print("MultiButton.Simple - OK")
                    } label: {
                        Text("OK")
                    }
                    Button(role: .cancel) {
                        print("MultiButton.Simple - Cancel")
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            
            Button {
                showComplex = true
            } label: {
                DetailLabel("Complex", detail: "CustomAlert using MultiButton with a slighly more complex layout")
            }
            .customAlert("MultiButton Alert", isPresented: $showComplex) {
                Text("Complex MultiButton")
            } actions: {
                MultiButton {
                    Button {
                        print("MultiButton.Complex - A")
                    } label: {
                        Text("A")
                    }

                    Button {
                        print("MultiButton.Complex - B")
                    } label: {
                        Text("B")
                    }
                    .disabled(false)

                    Button {
                        print("MultiButton.Complex - C")
                    } label: {
                        Text("C")
                    }
                }
                .disabled(true)

                Button(role: .cancel) {
                    print("MultiButton.Complex - Cancel")
                } label: {
                    Text("Cancel")
                }
            }
        } header: {
            Text("Multibutton")
        }
    }
}

#Preview {
    List {
        MultiButtonAlerts()
    }
}

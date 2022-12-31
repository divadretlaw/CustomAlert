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
                Text("Simple MultiButton")
            }
            .customAlert("Multibutton Alert", isPresented: $showSimple) {
                Text("Simple Multibutton")
            } actions: {
                MultiButton {
                    Button {
                        
                    } label: {
                        Text("OK")
                    }

                    Button(role: .cancel) {
                        
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            
            Button {
                showComplex = true
            } label: {
                Text("Complex MultiButton")
            }
            .customAlert("Multibutton Alert", isPresented: $showComplex) {
                Text("Complex Multibutton")
            } actions: {
                MultiButton {
                    Button {
                        
                    } label: {
                        Text("A")
                    }

                    Button {
                        
                    } label: {
                        Text("B")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("C")
                    }
                }
                
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
            }
        } header: {
            Text("Multibutton")
        }
    }
}

struct MultiButtonAlerts_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MultiButtonAlerts()
        }
    }
}

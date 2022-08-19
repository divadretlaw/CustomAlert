//
//  ContentView.swift
//  Demo
//
//  Created by David Walter on 19.08.22.
//

import SwiftUI
import CustomAlert

struct ContentView: View {
    @State private var showSimpleNative = false
    @State private var showSimpleCustom = false
    
    @State private var showSimpleMultiButton = false
    @State private var showComplexMultiButton = false
    
    @State private var showStacked = false
    @State private var showNoButton = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button {
                        showSimpleNative = true
                    } label: {
                        Text("Native Alert")
                    }
                    
                    Button {
                        showSimpleCustom = true
                    } label: {
                        Text("Custom Alert")
                    }
                } header: {
                    Text("Simple")
                }
                
                Section {
                    Button {
                        showSimpleMultiButton = true
                    } label: {
                        Text("Simple MultiButton")
                    }
                    Button {
                        showComplexMultiButton = true
                    } label: {
                        Text("Complex MultiButton")
                    }
                    
                    Button {
                        showNoButton = true
                    } label: {
                        Text("No Button")
                    }
                    
                    Button {
                        showStacked = true
                    } label: {
                        Text("Stacked")
                    }
                } header: {
                    Text("Custom")
                }
            }
            .navigationTitle("Custom Alert")
            .alert("Native Alert", isPresented: $showSimpleNative) {
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
            } message: {
                Text("Some Message")
            }
            .customAlert("Custom Alert", isPresented: $showSimpleCustom) {
                Text("Some Message")
            } actions: {
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
            }
            .customAlert("Multibutton Alert", isPresented: $showSimpleMultiButton) {
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
            .customAlert("Multibutton Alert", isPresented: $showComplexMultiButton) {
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
                
                Button {
                    
                } label: {
                    Text("Cancel")
                }
            }
            .customAlert("No Button Alert", isPresented: $showNoButton) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showNoButton = false
                        }
                    }
            } actions: {
                
            }
            .customAlert("Stacked", isPresented: $showStacked) {
                VStack {
                    HStack {
                        Text("Left")
                        Spacer()
                        Text("Right")
                    }
                    .padding(.horizontal)
                    
                    Image(systemName: "swift")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.orange)
                    
                    HStack {
                        Text("Left")
                        Spacer()
                        Text("Center")
                        Spacer()
                        Text("Right")
                    }
                    
                    HStack {
                        Text("Left")
                        Spacer()
                        Text("Noteworthy")
                        Spacer()
                        Text("Right")
                    }
                    .font(.custom("Noteworthy", size: 20))
                }
            } actions: {
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

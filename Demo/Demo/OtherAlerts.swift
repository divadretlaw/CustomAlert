//
//  OtherAlerts.swift
//  Demo
//
//  Created by David Walter on 31.12.22.
//

import SwiftUI
import CustomAlert

struct OtherAlerts: View {
    @State private var showStacked = false
    @State private var showFancy = false
    @State private var showNoButton = false
    
    @State private var message = ""
    
    var body: some View {
        Section {
            Button {
                showNoButton = true
            } label: {
                Text("No Button")
            }
            .customAlert("No Button Alert", isPresented: $showNoButton) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showNoButton = false
                        }
                    }
            }
            
            Button {
                showStacked = true
            } label: {
                Text("Stacked")
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
            
            Button {
                showFancy = true
            } label: {
                Text("Fancy")
            }
            .customAlert(isPresented: $showFancy) {
                VStack(spacing: 20) {
                    Image("jane")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .background(.ultraThinMaterial.blendMode(.multiply))
                        .clipShape(Circle())
                    
                    VStack(spacing: 4) {
                        Text("Remind Jane")
                            .font(.headline)
                        
                        Text("Send a reminder to Jane about \"Birthday Party\"")
                            .font(.footnote)
                    }
                    
                    TextField("Message", text: $message)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(.ultraThinMaterial.blendMode(.multiply))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            } actions: {
                MultiButton {
                    Button(role: .cancel) {
                        message = ""
                    } label: {
                        Text("Cancel")
                    }
                    
                    Button {
                        message = ""
                    } label: {
                        Text("Send")
                    }
                }
            }
        } header: {
            Text("Other")
        }
    }
}

struct OtherAlerts_Previews: PreviewProvider {
    static var previews: some View {
        List {
            OtherAlerts()
        }
    }
}

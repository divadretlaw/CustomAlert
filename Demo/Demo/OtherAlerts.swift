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
    @State private var showNoButton = false
    
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

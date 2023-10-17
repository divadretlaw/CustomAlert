//
//  CustomAlerts.swift
//  Demo
//
//  Created by David Walter on 17.10.23.
//

import SwiftUI
import CustomAlert

struct CustomAlerts: View {
    @State private var showAlert = false
    var body: some View {
        Section {
            Button {
                showAlert = true
            } label: {
                Text("Custom Button")
            }
            .customAlert(isPresented: $showAlert) {
                VStack {
                    Text("Preview")
                        .font(.title)
                    Text("Content")
                        .font(.body)
                }
            } actions: {
                MultiButton {
                    Button {
                    } label: {
                        Text("OK")
                    }
                    Button {
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .environment(\.customAlertConfiguration, .create { configuration in
                configuration.background = .color(.white)
                configuration.windowBackground = .blurEffect(.dark)
                configuration.cornerRadius = 0
                configuration.contentPadding = EdgeInsets(top: 10, leading: 4, bottom: 10, trailing: 4)
                configuration.alertPadding = EdgeInsets()
                configuration.minWidth = 300
                configuration.buttonConfiguration = .create { button in
                    button.tintColor = .green
                    button.padding = EdgeInsets(top: 15, leading: 4, bottom: 15, trailing: 4)
                    button.font = .title3.weight(.black)
                    button.hideDivider = true
                }
            })
        }
    }
}

struct CustomAlerts_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CustomAlerts()
        }
    }
}

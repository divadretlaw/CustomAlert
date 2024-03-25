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
            .customAlert("Preview", isPresented: $showAlert) {
                Text("Content")
            } actions: {
                MultiButton {
                    Button {
                    } label: {
                        Text("Cancel")
                    }
                    Button {
                    } label: {
                        Text("OK")
                    }
                }
            }
            .environment(\.customAlertConfiguration, .create { configuration in
                configuration.background = .blurEffect(.dark)
                configuration.padding = EdgeInsets()
                configuration.alert = .create { alert in
                    alert.background = .color(.white)
                    alert.cornerRadius = 4
                    alert.padding = EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20)
                    alert.minWidth = 300
                    alert.titleFont = .headline
                    alert.contentFont = .subheadline
                    alert.alignment = .leading
                    alert.spacing = 10
                }
                configuration.button = .create { button in
                    button.tintColor = .purple
                    button.padding = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                    button.font = .callout.weight(.semibold)
                    button.hideDivider = true
                }
            })
        }
    }
}


#Preview {
    List {
        CustomAlerts()
    }
}

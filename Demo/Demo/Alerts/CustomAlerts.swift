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
    
    @State private var showChangingAlert = false
    @State private var next: Int = 0
    
    var body: some View {
        Section {
            Button {
                showAlert = true
            } label: {
                DetailLabel("Custom Config", detail: "CustomAlert with heavily modified styling")
            }
            .customAlert("Preview", isPresented: $showAlert) {
                CustomContent()
            } actions: {
                MultiButton {
                    Button {
                        print("CustomStyling.MyConfig - Cancel")
                    } label: {
                        Text("Cancel")
                    }
                    Button(role: .destructive) {
                        print("CustomStyling.MyConfig - Delete")
                    } label: {
                        Text("Delete")
                    }
                }
            }
            .configureCustomAlert(.myConfig)
            Button {
                next = 0
                showChangingAlert = true
            } label: {
                DetailLabel("Changing Alert", detail: "CustomAlert that changes")
            }
            .customAlert("Preview", isPresented: $showChangingAlert) {
                ZStack {
                    Group {
                        switch next {
                        case 0:
                            Text("Initial Content. Press next to continue.")
                        case 1:
                            Text("Content changed, to display the next step. Press next to continue.")
                        default:
                            Text("Final Content. Press done to dismiss the alert.")
                        }
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
                .animation(.default, value: next)
            } actions: {
                MultiButton {
                    Button(role: .cancel) {
                        print("CustomStyling.MyConfig - Cancel")
                    } label: {
                        Text("Cancel")
                    }
                    ZStack {
                        switch next {
                        case 0, 1:
                            Button {
                                next += 1
                            } label: {
                                Text("Next")
                            }
                            .transition(.opacity)
                            .buttonStyle(.alert(triggerDismiss: false))
                        default:
                            Button(role: .destructive) {
                                print("CustomStyling.MyConfig - Done")
                            } label: {
                                Text("Done")
                            }
                            .transition(.opacity)
                        }
                    }
                    .animation(.default, value: next)
                }
            }
        } header: {
            Text("Custom Styling")
        }
    }
}

struct CustomContent: View {
    @Environment(\.alertDismiss) private var alertDismiss
    @Environment(\.customAlertConfiguration) private var configuration
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Content")
            
            Button {
                alertDismiss()
            } label: {
                Text("Custom Dismiss Button")
            }
            .buttonStyle(.bordered)
            .tint(configuration.button.tintColor)
        }
    }
}

extension CustomAlertConfiguration {
    static var myConfig: CustomAlertConfiguration = .create { configuration in
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
            button.pressedTintColor = .white
            button.padding = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            button.font = .callout.weight(.semibold)
            button.hideDivider = true
            button.pressedBackground = .color(.purple)
        }
    }
}

#Preview {
    List {
        CustomAlerts()
    }
}

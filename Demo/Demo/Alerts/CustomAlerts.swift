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
                    switch next {
                    case 0, 1:
                        Button {
                            next += 1
                        } label: {
                            Text("Next")
                        }
                        .dismissDisabled(true)
                    default:
                        Button(role: .destructive) {
                            print("CustomStyling.MyConfig - Done")
                        } label: {
                            Text("Done")
                        }
                    }
                }
            }
        } header: {
            Text("Custom Styling")
        }
    }
}

struct CustomContent: View {
    @Environment(\.alertDismiss) private var alertDismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Content")
            
            Button {
                alertDismiss()
            } label: {
                Text("Custom Dismiss Button")
            }
            .buttonStyle(.bordered)
        }
    }
}

extension CustomAlertConfiguration {
    static let myConfig: CustomAlertConfiguration = {
        CustomAlertConfiguration()
            .background(.blurEffect(.dark))
            .padding(EdgeInsets())
            .alert {
                CustomAlertConfiguration.Alert()
                    .background(.color(.white))
                    .cornerRadius(4)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20))
                    .minWidth(300)
                    .titleFont(.headline)
                    .contentFont(.subheadline)
                    .alignment(.leading)
                    .spacing(10)
            }
            .button {
                CustomAlertConfiguration.Button()
                    .tintColor(.purple)
                    .pressedTintColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .font(.callout.weight(.semibold))
                    .hideDivider(true)
                    .pressedBackground(.color(.purple))
            }
    }()
}

#Preview {
    List {
        CustomAlerts()
    }
}

//
//  CustomAlert+ViewModifier.swift
//  CustomAlert
//
//  Created by David Walter on 28.06.23.
//

import SwiftUI
import WindowSceneReader
import Combine

struct CustomAlertHandler<AlertContent, AlertActions>: ViewModifier where AlertContent: View, AlertActions: View {
    var title: Text?
    @Binding var isPresented: Bool
    var windowScene: UIWindowScene
    var alertContent: () -> AlertContent
    var alertActions: () -> AlertActions
    
    func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            content
                .disabled(isPresented)
                .onChange(of: isPresented) { value in
                    if value {
                        AlertWindow.present(on: windowScene) {
                            CustomAlert(title: title, isPresented: $isPresented, content: alertContent, actions: alertActions)
                        }
                    } else {
                        AlertWindow.dismiss(on: windowScene)
                    }
                }
                .onAppear {
                    guard isPresented else { return }
                    AlertWindow.present(on: windowScene) {
                        CustomAlert(title: title, isPresented: $isPresented, content: alertContent, actions: alertActions)
                    }
                }
                .onDisappear {
                    AlertWindow.dismiss(on: windowScene)
                }
        } else {
            content
                .disabled(isPresented)
                .onReceive(Just(isPresented)) { value in
                    if value {
                        AlertWindow.present(on: windowScene) {
                            CustomAlert(title: title, isPresented: $isPresented, content: alertContent, actions: alertActions)
                        }
                    } else {
                        // Cannot use this to hide the alert on iOS 13 because `onReceive`
                        // will get called for all alerts if there are multiple on a single view
                        // causing all alerts to be hidden immediately after appearing
                    }
                }
                .onDisappear {
                    AlertWindow.dismiss(on: windowScene)
                }
        }
    }
}

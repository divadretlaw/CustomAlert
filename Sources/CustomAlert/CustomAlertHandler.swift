//
//  CustomAlertHandler.swift
//  CustomAlert
//
//  Created by David Walter on 28.06.23.
//

import SwiftUI
import Combine
import WindowKit

struct CustomAlertHandler<AlertContent, AlertActions>: ViewModifier where AlertContent: View, AlertActions: View {    
    var title: Text?
    @Binding var isPresented: Bool
    var windowScene: UIWindowScene?
    var alertContent: () -> AlertContent
    var alertActions: () -> AlertActions
    
    func body(content: Content) -> some View {
        if let windowScene = windowScene {
            content
                .disabled(isPresented)
                .windowCover("CustomAlert", isPresented: $isPresented, on: windowScene) {
                    CustomAlert(title: title, isPresented: $isPresented, content: alertContent, actions: alertActions)
                        .transformEnvironment(\.isEnabled) { isEnabled in
                            isEnabled = true
                        }
                } configure: { configuration in
                    let traitCollection = UITraitCollection(activeAppearance: .active)
                    if #available(iOS 15.0, *) {
                        configuration.tintColor = .tintColor.resolvedColor(with: traitCollection)
                    } else {
                        configuration.tintColor = UIColor(named: "AccentColor", in: .main, compatibleWith: traitCollection) ?? .systemBlue
                    }
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
        } else {
            content
                .disabled(isPresented)
                .windowCover("CustomAlert", isPresented: $isPresented) {
                    CustomAlert(title: title, isPresented: $isPresented, content: alertContent, actions: alertActions)
                        .transformEnvironment(\.isEnabled) { isEnabled in
                            isEnabled = true
                        }
                } configure: { configuration in
                    let traitCollection = UITraitCollection(activeAppearance: .active)
                    if #available(iOS 15.0, *) {
                        configuration.tintColor = .tintColor.resolvedColor(with: traitCollection)
                    } else {
                        configuration.tintColor = UIColor(named: "AccentColor", in: .main, compatibleWith: traitCollection) ?? .systemBlue
                    }
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
        }
    }
}

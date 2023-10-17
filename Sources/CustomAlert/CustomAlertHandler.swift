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
    @Environment(\.customAlertConfiguration) private var configuration
    
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
                    configuration.tintColor = .customAlertColor
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
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
        }
    }
}

private extension UIColor {
    static var customAlertColor: UIColor {
        let traitCollection = UITraitCollection(activeAppearance: .active)
        if #available(iOS 15.0, *) {
            return .tintColor.resolvedColor(with: traitCollection)
        } else {
            return UIColor(
                named: "AccentColor",
                in: .main,
                compatibleWith: traitCollection
            ) ?? .systemBlue
        }
    }
}

//
//  CustomAlertHandler.swift
//  CustomAlert
//
//  Created by David Walter on 28.06.23.
//

import SwiftUI
import Combine
import WindowKit

private final class ColorSchemeResolver: ObservableObject {
    @Published var colorScheme: ColorScheme?
}

struct CustomAlertHandler<AlertContent, AlertActions>: ViewModifier where AlertContent: View, AlertActions: View {
    @Environment(\.customAlertConfiguration) private var configuration
    @Environment(\.colorScheme) private var colorScheme
    
    var title: Text?
    @Binding var isPresented: Bool
    var windowScene: UIWindowScene?
    var alertContent: () -> AlertContent
    var alertActions: () -> AlertActions
    
    @StateObject private var colorSchemeResolver = ColorSchemeResolver()
    
    func body(content: Content) -> some View {
        if let windowScene = windowScene {
            content
                .disabled(isPresented)
                .windowCover("CustomAlert", isPresented: $isPresented, on: windowScene) {
                    CustomAlert(title: title, isPresented: $isPresented, content: alertContent, actions: alertActions)
                        .transformEnvironment(\.self) { environment in
                            environment.isEnabled = true
                            if let colorScheme = colorSchemeResolver.colorScheme {
                                environment.colorScheme = colorScheme
                            }
                        }
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
                .onChange(of: colorScheme) { colorScheme in
                    colorSchemeResolver.colorScheme = colorScheme
                }
        } else {
            content
                .disabled(isPresented)
                .windowCover("CustomAlert", isPresented: $isPresented) {
                    CustomAlert(title: title, isPresented: $isPresented, content: alertContent, actions: alertActions)
                        .transformEnvironment(\.self) { environment in
                            environment.isEnabled = true
                            if let colorScheme = colorSchemeResolver.colorScheme {
                                environment.colorScheme = colorScheme
                            }
                        }
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
                .onChange(of: colorScheme) { colorScheme in
                    colorSchemeResolver.colorScheme = colorScheme
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

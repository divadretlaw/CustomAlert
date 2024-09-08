//
//  CustomAlertHandler.swift
//  CustomAlert
//
//  Created by David Walter on 26.05.24.
//

import SwiftUI
import Combine
import WindowKit

@MainActor struct CustomAlertHandler<AlertContent, AlertActions>: ViewModifier where AlertContent: View, AlertActions: View {
    @Environment(\.customAlertConfiguration) private var configuration
    
    @Binding var isPresented: Bool
    var windowScene: UIWindowScene?
    var alertTitle: () -> Text?
    @ViewBuilder var alertContent: () -> AlertContent
    @ViewBuilder var alertActions: () -> AlertActions
    
    init(
        isPresented: Binding<Bool>,
        windowScene: UIWindowScene? = nil,
        alertTitle: @escaping () -> Text?,
        @ViewBuilder alertContent: @escaping () -> AlertContent,
        @ViewBuilder alertActions: @escaping () -> AlertActions
    ) {
        self._isPresented = isPresented
        self.windowScene = windowScene
        self.alertTitle = alertTitle
        self.alertContent = alertContent
        self.alertActions = alertActions
    }
    
    func body(content: Content) -> some View {
        if let windowScene {
            content
                .disabled(isPresented)
                .windowCover(isPresented: $isPresented, on: windowScene) {
                    alertView
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
                .background(alertIdentity)
        } else {
            content
                .disabled(isPresented)
                .windowCover(isPresented: $isPresented) {
                    alertView
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
                .background(alertIdentity)
        }
    }
    
    var alertView: some View {
        CustomAlert(isPresented: $isPresented) {
            alertTitle()
        } content: {
            alertContent()
        } actions: {
            alertActions()
        }
        .transformEnvironment(\.self) { environment in
            environment.isEnabled = true
        }
    }
    
    /// The view identity of the alert
    ///
    /// The `alertIdentity` represents the individual parts of the alert but combined into a single view.
    ///
    /// When attached to the content of the represeting view, any changes here will propagate to the content of the window which hosts the alert.
    @ViewBuilder var alertIdentity: some View {
        ZStack {
            alertTitle()
            alertContent()
            alertActions()
        }
        .accessibilityHidden(true)
        .frame(width: 0, height: 0)
        .hidden()
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

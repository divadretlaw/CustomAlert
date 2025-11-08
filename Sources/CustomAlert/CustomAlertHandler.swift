//
//  CustomAlertHandler.swift
//  CustomAlert
//
//  Created by David Walter on 26.05.24.
//

import SwiftUI
import WindowKit

@MainActor struct CustomAlertHandler<AlertContent>: ViewModifier where AlertContent: View {
    @Environment(\.customAlertConfiguration) private var configuration

    @Binding var isPresented: Bool
    let windowScene: UIWindowScene?
    let alertTitle: () -> Text?
    @ViewBuilder let alertContent: () -> AlertContent
    @ActionBuilder let alertActions: () -> [CustomAlertAction]

    init(
        isPresented: Binding<Bool>,
        windowScene: UIWindowScene? = nil,
        alertTitle: @escaping () -> Text?,
        @ViewBuilder alertContent: @escaping () -> AlertContent,
        @ActionBuilder alertActions: @escaping () -> [CustomAlertAction]
    ) {
        self._isPresented = isPresented
        self.windowScene = windowScene
        self.alertTitle = alertTitle
        self.alertContent = alertContent
        self.alertActions = alertActions
    }

    func body(content: Content) -> some View {
        content
            .disabled(isPresented)
            .background {
                if let windowScene {
                    alert(on: windowScene)
                } else {
                    WindowSceneReader { windowScene in
                        alert(on: windowScene)
                    }
                }
            }
    }

    func alert(on windowScene: UIWindowScene) -> some View {
        alertIdentity
            .windowCover(isPresented: $isPresented, on: windowScene) {
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
            } configure: { configuration in
                configuration.tintColor = .customAlertColor
                configuration.modalPresentationStyle = .overFullScreen
                configuration.modalTransitionStyle = .crossDissolve
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
            ForEach(Array(alertActions().enumerated()), id: \.offset) { _, action in
                action
            }
        }
        .accessibilityHidden(true)
        .frame(width: 0, height: 0)
        .hidden()
    }
}

private extension UIColor {
    static var customAlertColor: UIColor {
        let traitCollection = UITraitCollection(activeAppearance: .active)
        return .tintColor.resolvedColor(with: traitCollection)
    }
}

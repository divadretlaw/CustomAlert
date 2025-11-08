//
//  CustomAlertHandler+Item.swift
//  CustomAlert
//
//  Created by David Walter on 28.06.23.
//

import SwiftUI
import WindowKit

@MainActor struct CustomAlertItemHandler<AlertItem, AlertContent>: ViewModifier where AlertItem: Identifiable, AlertContent: View {
    @Environment(\.customAlertConfiguration) private var configuration

    @Binding var item: AlertItem?
    let windowScene: UIWindowScene?
    let alertTitle: () -> Text?
    @ViewBuilder let alertContent: (AlertItem) -> AlertContent
    @ActionBuilder let alertActions: (AlertItem) -> [CustomAlertAction]

    init(
        item: Binding<AlertItem?>,
        windowScene: UIWindowScene? = nil,
        alertTitle: @escaping () -> Text?,
        @ViewBuilder alertContent: @escaping (AlertItem) -> AlertContent,
        @ActionBuilder alertActions: @escaping (AlertItem) -> [CustomAlertAction]
    ) {
        self._item = item
        self.windowScene = windowScene
        self.alertTitle = alertTitle
        self.alertContent = alertContent
        self.alertActions = alertActions
    }

    func body(content: Content) -> some View {
        content
            .disabled(item != nil)
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
            .windowCover(item: $item, on: windowScene) { item in
                CustomAlert(isPresented: isPresented) {
                    alertTitle()
                } content: {
                    alertContent(item)
                } actions: {
                    alertActions(item)
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
        if let item {
            ZStack {
                alertTitle()
                alertContent(item)
                ForEach(Array(alertActions(item).enumerated()), id: \.offset) { _, action in
                    action
                }
            }
            .accessibilityHidden(true)
            .frame(width: 0, height: 0)
            .hidden()
        } else {
            Color.clear
        }
    }

    private var isPresented: Binding<Bool> {
        Binding {
            item != nil
        } set: { newValue in
            guard !newValue else { return }
            item = nil
        }
    }
}

private extension UIColor {
    static var customAlertColor: UIColor {
        let traitCollection = UITraitCollection(activeAppearance: .active)
        return .tintColor.resolvedColor(with: traitCollection)
    }
}

//
//  CustomAlertHandler+Item.swift
//  CustomAlert
//
//  Created by David Walter on 28.06.23.
//

import SwiftUI
import Combine
import WindowKit

@MainActor struct CustomAlertItemHandler<AlertItem, AlertContent, AlertActions>: ViewModifier where AlertItem: Identifiable, AlertContent: View, AlertActions: View {
    @Environment(\.customAlertConfiguration) private var configuration
    
    @Binding var item: AlertItem?
    var windowScene: UIWindowScene?
    var alertTitle: () -> Text?
    @ViewBuilder var alertContent: (AlertItem) -> AlertContent
    @ViewBuilder var alertActions: (AlertItem) -> AlertActions
    
    init(
        item: Binding<AlertItem?>,
        windowScene: UIWindowScene? = nil,
        alertTitle: @escaping () -> Text?,
        @ViewBuilder alertContent: @escaping (AlertItem) -> AlertContent,
        @ViewBuilder alertActions: @escaping (AlertItem) -> AlertActions
    ) {
        self._item = item
        self.windowScene = windowScene
        self.alertTitle = alertTitle
        self.alertContent = alertContent
        self.alertActions = alertActions
    }
    
    func body(content: Content) -> some View {
        if let windowScene {
            content
                .disabled(item != nil)
                .windowCover(item: $item, on: windowScene) { item in
                    alertView(for: item)
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
                .background(alertIdentity)
        } else {
            content
                .disabled(item != nil)
                .windowCover(item: $item) { item in
                    alertView(for: item)
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
                .background(alertIdentity)
        }
    }
    
    
    func alertView(for item: AlertItem) -> some View {
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
                alertActions(item)
            }
            .accessibilityHidden(true)
            .frame(width: 0, height: 0)
            .hidden()
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

//
//  CustomAlertHandler.swift
//  CustomAlert
//
//  Created by David Walter on 28.06.23.
//

import SwiftUI
import Combine
import WindowKit

struct CustomAlertHandler<AlertItem, AlertContent, AlertActions>: ViewModifier where AlertItem: Identifiable, AlertContent: View, AlertActions: View {
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
        if let windowScene = windowScene {
            content
                .disabled(item != nil)
                .windowCover("CustomAlert", isPresented: isPresented, on: windowScene) {
                    alert
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
        } else {
            content
                .disabled(item != nil)
                .windowCover("CustomAlert", isPresented: isPresented) {
                    alert
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
        }
    }
    
    @ViewBuilder
    var alert: some View {
        if let item {
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

extension CustomAlertHandler where AlertItem == AlertIdentifiable {
    init(
        isPresented: Binding<Bool>,
        windowScene: UIWindowScene?,
        alertTitle: @escaping () -> Text?,
        @ViewBuilder alertContent: @escaping () -> AlertContent,
        @ViewBuilder alertActions: @escaping () -> AlertActions
    ) {
        self._item = isPresented.alert()
        self.windowScene = windowScene
        self.alertTitle = alertTitle
        self.alertContent = { _ in alertContent() }
        self.alertActions = { _ in alertActions() }
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

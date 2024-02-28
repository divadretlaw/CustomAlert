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
    
    var title: Text?
    @Binding var item: AlertItem?
    var windowScene: UIWindowScene?
    var alertContent: (AlertItem) -> AlertContent
    var alertActions: (AlertItem) -> AlertActions
    
    init(
        title: Text? = nil,
        item: Binding<AlertItem?>,
        windowScene: UIWindowScene? = nil,
        alertContent: @escaping (AlertItem) -> AlertContent,
        alertActions: @escaping (AlertItem) -> AlertActions
    ) {
        self.title = title
        self._item = item
        self.windowScene = windowScene
        self.alertContent = alertContent
        self.alertActions = alertActions
    }
    
    func body(content: Content) -> some View {
        if let windowScene = windowScene {
            content
                .windowCover("CustomAlert", isPresented: isPresented, on: windowScene) {
                    if let item {
                        CustomAlert(title: title, isPresented: isPresented) {
                            alertContent(item)
                        } actions: {
                            alertActions(item)
                        }
                        .transformEnvironment(\.self) { environment in
                            environment.isEnabled = true
                        }
                    }
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
                }
        } else {
            content
                .disabled(item != nil)
                .windowCover("CustomAlert", isPresented: isPresented) {
                    if let item {
                        CustomAlert(title: title, isPresented: isPresented) {
                            alertContent(item)
                        } actions: {
                            alertActions(item)
                        }
                        .transformEnvironment(\.self) { environment in
                            environment.isEnabled = true
                        }
                    }
                } configure: { configuration in
                    configuration.tintColor = .customAlertColor
                    configuration.modalPresentationStyle = .overFullScreen
                    configuration.modalTransitionStyle = .crossDissolve
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
        title: Text? = nil,
        isPresented: Binding<Bool>,
        windowScene: UIWindowScene? = nil,
        alertContent: @escaping () -> AlertContent,
        alertActions: @escaping () -> AlertActions
    ) {
        self.title = title
        self._item = isPresented.alert()
        self.windowScene = windowScene
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

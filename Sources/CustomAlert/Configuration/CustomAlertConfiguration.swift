//
//  CustomAlertConfiguration.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI

/// Configuration values for custom alerts
@MainActor public struct CustomAlertConfiguration: Sendable {
    /// The configuration of the alert view
    var alert: Alert
    /// The configuration of the alert buttons
    var button: Button
    /// The window background behind the alert
    var background: CustomAlertBackground
    /// The padding around the alert
    var padding: EdgeInsets
    /// The transition the alert appears with
    var transition: AnyTransition
    /// Animate the alert appearance
    var animateTransition: Bool
    /// The vertical alignment of the alert
    var alignment: VerticalAlignment
    /// Allow dismissing the alert when tapping on the background
    var dismissOnBackgroundTap: Bool

    // MARK: - Init

    public init() {
        self = .default
    }

    private init(
        alert: CustomAlertConfiguration.Alert,
        button: CustomAlertConfiguration.Button,
        background: CustomAlertBackground,
        padding: EdgeInsets,
        transition: AnyTransition,
        animateTransition: Bool,
        alignment: VerticalAlignment,
        dismissOnBackgroundTap: Bool
    ) {
        self.alert = alert
        self.button = button
        self.background = background
        self.padding = padding
        self.transition = transition
        self.animateTransition = animateTransition
        self.alignment = alignment
        self.dismissOnBackgroundTap = dismissOnBackgroundTap
    }

    /// The default configuration
    public static nonisolated var `default`: CustomAlertConfiguration {
        if #available(iOS 26.0, *) {
            .liquidGlass
        } else {
            .classic
        }
    }

    /// The default configuration for a liquid glass alert
    @available(iOS 26.0, *)
    public static nonisolated var liquidGlass: CustomAlertConfiguration {
        MainActor.runSync {
            CustomAlertConfiguration(
                alert: .liquidGlass,
                button: .liquidGlass,
                background: .color(Color("DimmingBackround", bundle: .module)),
                padding: EdgeInsets(top: 11, leading: 20, bottom: 11, trailing: 20),
                transition: .opacity.combined(with: .scale(scale: 1.1)),
                animateTransition: true,
                alignment: .center,
                dismissOnBackgroundTap: false
            )
        }
    }

    /// The default configuration for a classic alert
    public static nonisolated var classic: CustomAlertConfiguration {
        MainActor.runSync {
            CustomAlertConfiguration(
                alert: .classic,
                button: .classic,
                background: .color(Color("DimmingBackround", bundle: .module)),
                padding: EdgeInsets(top: 11, leading: 30, bottom: 11, trailing: 30),
                transition: .opacity.combined(with: .scale(scale: 1.1)),
                animateTransition: true,
                alignment: .center,
                dismissOnBackgroundTap: false
            )
        }
    }

    // MARK: - Modifier

    /// Set the configuration of the alert view
    public func alert(_ value: Alert) -> Self {
        var configuration = self
        configuration.alert = value
        return configuration
    }

    /// Create the configuration of the alert view
    public func alert(_ build: () -> Alert) -> Self {
        var configuration = self
        configuration.alert = build()
        return configuration
    }

    /// Adapt the configuration of the alert view
    public func alert(_ build: (Alert) -> Alert) -> Self {
        var configuration = self
        configuration.alert = build(alert)
        return configuration
    }

    /// Set the configuration of the alert buttons
    public func button(_ value: Button) -> Self {
        var configuration = self
        configuration.button = value
        return configuration
    }

    /// Create the configuration of the alert buttons
    public func button(_ build: () -> Button) -> Self {
        var configuration = self
        configuration.button = build()
        return configuration
    }

    /// Adapt the configuration of the alert buttons
    public func button(_ build: (Button) -> Button) -> Self {
        var configuration = self
        configuration.button = build(button)
        return configuration
    }

    /// The window background behind the alert
    public func background(_ value: CustomAlertBackground) -> Self {
        var configuration = self
        configuration.background = value
        return configuration
    }

    /// The padding around the alert
    public func padding(_ value: EdgeInsets) -> Self {
        var configuration = self
        configuration.padding = value
        return configuration
    }

    /// The transition the alert appears with
    public func transition(_ value: AnyTransition) -> Self {
        var configuration = self
        configuration.transition = value
        return configuration
    }

    /// Animate the alert appearance
    public func animateTransition(_ value: Bool) -> Self {
        var configuration = self
        configuration.animateTransition = value
        return configuration
    }

    /// The vertical alignment of the alert
    public func alignment(_ value: VerticalAlignment) -> Self {
        var configuration = self
        configuration.alignment = value
        return configuration
    }

    /// Allow dismissing the alert when tapping on the background
    public func dismissOnBackgroundTap(_ value: Bool) -> Self {
        var configuration = self
        configuration.dismissOnBackgroundTap = value
        return configuration
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("Default") {
    AlertPreview(title: "Title", content: "Content")
}

@available(iOS 17.0, *)
#Preview("Lorem Ipsum") {
    AlertPreview(title: "Title", content: .loremIpsum)
}
#endif

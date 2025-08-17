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
    public var alert: Alert
    /// The configuration of the alert buttons
    public var button: Button
    /// The window background behind the alert
    public var background: CustomAlertBackground
    /// The padding around the alert
    public var padding: EdgeInsets
    /// The transition the alert appears with
    public var transition: AnyTransition
    /// Animate the alert appearance
    public var animateTransition: Bool
    /// The vertical alginment of the alert
    public var alignment: VerticalAlignment
    /// Allow dismissing the alert when tapping on the background
    public var dismissOnBackgroundTap: Bool

    init(
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
    /// Create a custom configuration
    ///
    /// - Parameter configure: Callback to change the default configuration
    ///
    /// - Returns: The customized ``CustomAlertConfiguration`` configuration
    public static func create(configure: (inout Self) -> Void) -> Self {
        var configuration = CustomAlertConfiguration.default
        configure(&configuration)
        return configuration
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

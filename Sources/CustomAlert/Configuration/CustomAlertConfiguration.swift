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
    
    public init() {
        self.alert = .init()
        self.button = .init()
        self.background = .color(Color.black.opacity(0.2))
        self.padding = EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        self.transition = .opacity.combined(with: .scale(scale: 1.1))
        self.animateTransition = true
        self.alignment = .center
        self.dismissOnBackgroundTap = false
    }
    
    /// Create a custom configuration
    ///
    /// - Parameter configure: Callback to change the default configuration
    ///
    /// - Returns: The customized ``CustomAlertConfiguration`` configuration
    public static func create(configure: (inout Self) -> Void) -> Self {
        var configuration = Self()
        configure(&configuration)
        return configuration
    }
    
    /// The default configuration
    public static nonisolated var `default`: CustomAlertConfiguration {
        MainActor.runSync {
            CustomAlertConfiguration()
        }
    }
}

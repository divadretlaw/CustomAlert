//
//  CustomAlertConfiguration.Button.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI

extension CustomAlertConfiguration {
    /// Configuration values of a custom alert button
    public struct Button: Sendable {
        /// The tint color of the alert button
        var tintColor: Color?
        /// The pressed tint color of the alert button
        var pressedTintColor: Color?
        /// The tint color of the alert button for a given role
        var roleColor: [ButtonType: Color]
        /// The padding of the button
        var padding: Value<EdgeInsets>
        /// The font of the alert button
        var font: Font
        /// The font of the alert button for a given role
        var roleFont: [ButtonType: Font]
        /// Whether to hide the dividers between the buttons
        var hideDivider: Bool
        /// The background of the alert button
        var background: CustomAlertBackground
        /// The pressed background of the alert button
        var pressedBackground: CustomAlertBackground
        /// The background of the alert button for a given role
        var roleBackground: [ButtonType: CustomAlertBackground]
        /// The spacing between buttons
        var spacing: CGFloat
        /// The shape of the buttons
        var shape: ButtonBorderShape

        // MARK: - Init

        public init() {
            self = .default
        }

        internal init(
            tintColor: Color?,
            pressedTintColor: Color?,
            roleColor: [ButtonType: Color],
            padding: CustomAlertConfiguration.Value<EdgeInsets>,
            font: Font,
            roleFont: [ButtonType: Font],
            hideDivider: Bool,
            background: CustomAlertBackground,
            pressedBackground: CustomAlertBackground,
            roleBackground: [ButtonType: CustomAlertBackground],
            spacing: CGFloat,
            shape: ButtonBorderShape
        ) {
            self.tintColor = tintColor
            self.pressedTintColor = pressedTintColor
            self.roleColor = roleColor
            self.padding = padding
            self.font = font
            self.roleFont = roleFont
            self.hideDivider = hideDivider
            self.background = background
            self.pressedBackground = pressedBackground
            self.roleBackground = roleBackground
            self.spacing = spacing
            self.shape = shape
        }

        /// The default configuration
        nonisolated public static var `default`: CustomAlertConfiguration.Button {
            if #available(iOS 26.0, visionOS 26.0, *) {
                .liquidGlass
            } else {
                .classic
            }
        }

        // MARK: - Modifier

        /// The tint color of the alert button
        public func tintColor(_ value: Color?) -> Self {
            var configuration = self
            configuration.tintColor = value
            return configuration
        }

        /// The pressed tint color of the alert button
        public func pressedTintColor(_ value: Color?) -> Self {
            var configuration = self
            configuration.pressedTintColor = value
            return configuration
        }

        /// The tint color of the alert button for the given role
        ///
        /// - Parameters:
        ///   - color: The color to use.
        ///   - role: The role to set the color for.
        ///
        /// Takes presedence over ``tintColor(_:)``
        public func tintColor(_ color: Color, for role: ButtonRole) -> Self {
            guard let type = ButtonType(from: role) else { return self }
            var configuration = self
            configuration.roleColor[type] = color
            return configuration
        }

        public func padding(_ value: EdgeInsets) -> Self {
            var configuration = self
            configuration.padding = .static(value)
            return configuration
        }

        public func padding(_ value: @Sendable @escaping (CustomAlertState) -> EdgeInsets) -> Self {
            var configuration = self
            configuration.padding = .dynamic(value)
            return configuration
        }

        /// The font of the alert button
        public func font(_ value: Font) -> Self {
            var configuration = self
            configuration.font = value
            return configuration
        }

        /// The font of the alert button for the given role
        ///
        /// - Parameters:
        ///   - color: The font to use.
        ///   - role: The role to set the font for.
        ///
        /// Takes presedence over ``font(_:)``
        public func font(_ value: Font, for role: ButtonRole) -> Self {
            guard let type = ButtonType(from: role) else { return self }

            var configuration = self
            configuration.roleFont[type] = value
            return configuration
        }

        /// Whether to hide the dividers between the buttons
        public func hideDivider(_ value: Bool) -> Self {
            var configuration = self
            configuration.hideDivider = value
            return configuration
        }

        /// The background of the alert button
        public func background(_ value: CustomAlertBackground) -> Self {
            var configuration = self
            configuration.background = value
            return configuration
        }

        /// The pressed background of the alert button
        public func pressedBackground(_ value: CustomAlertBackground) -> Self {
            var configuration = self
            configuration.pressedBackground = value
            return configuration
        }

        /// The background of the alert button for the given role
        ///
        /// - Parameters:
        ///   - color: The background to use.
        ///   - role: The role to set the background for.
        ///
        /// Takes presedence over ``background(_:)``
        public mutating func background(_ value: CustomAlertBackground, for role: ButtonRole) -> Self {
            guard let type = ButtonType(from: role) else { return self }

            var configuration = self
            configuration.roleBackground[type] = value
            return configuration
        }

        /// The spacing between buttons
        public func spacing(_ value: CGFloat) -> Self {
            var configuration = self
            configuration.spacing = value
            return configuration
        }

        /// The shape of the buttons
        public func shape(_ value: ButtonBorderShape) -> Self {
            var configuration = self
            configuration.shape = value
            return configuration
        }
    }
}

/// Internal button type because `ButtonRole` is not `Hashable`
enum ButtonType: Hashable {
    case destructive
    case cancel

    init?(from role: ButtonRole) {
        switch role {
        case .destructive:
            self = .destructive
        case .cancel:
            self = .cancel
        default:
            return nil
        }
    }
}

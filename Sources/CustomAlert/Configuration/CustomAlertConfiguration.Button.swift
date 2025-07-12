//
//  CustomAlertConfiguration.Button.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI

extension CustomAlertConfiguration {
    public struct Button: Sendable {
        /// Configuration values of a custom alert button
        /// The tint color of the alert button
        public var tintColor: Color?
        /// The pressed tint color of the alert button
        public var pressedTintColor: Color?
        internal var roleColor: [ButtonType: Color]
        /// The padding of the alert button
        public var padding: EdgeInsets
        /// The padding of the alert button when using accessibility scaling
        public var accessibilityPadding: EdgeInsets
        /// The font of the alert button
        public var font: Font
        internal var roleFont: [ButtonType: Font]
        /// Whether to hide the dividers between the buttons
        public var hideDivider: Bool
        /// The background of the alert button
        public var background: CustomAlertBackground
        /// The pressed background of the alert button
        public var pressedBackground: CustomAlertBackground
        internal var roleBackground: [ButtonType: CustomAlertBackground]
        /// The spacing between buttons
        public var spacing: CGFloat
        /// The shape of the buttons
        public var shape: ButtonBorderShape

        init(
            tintColor: Color?,
            pressedTintColor: Color?,
            roleColor: [ButtonType: Color],
            padding: EdgeInsets,
            accessibilityPadding: EdgeInsets,
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
            self.accessibilityPadding = accessibilityPadding
            self.font = font
            self.roleFont = roleFont
            self.hideDivider = hideDivider
            self.background = background
            self.pressedBackground = pressedBackground
            self.roleBackground = roleBackground
            self.spacing = spacing
            self.shape = shape
        }

        /// Create a custom configuration
        ///
        /// - Parameter configure: Callback to change the default configuration
        ///
        /// - Returns: The customized ``CustomAlertConfiguration/Button`` configuration
        public static func create(configure: (inout Self) -> Void) -> Self {
            var configuration = CustomAlertConfiguration.Button.default
            configure(&configuration)
            return configuration
        }

        /// The default configuration
        public nonisolated static var `default`: CustomAlertConfiguration.Button {
            if #available(iOS 26.0, *) {
                .liquidGlass
            } else {
                .classic
            }
        }

        /// The default configuration for a liquid glass alert
        public nonisolated static var liquidGlass: CustomAlertConfiguration.Button {
            MainActor.runSync {
                CustomAlertConfiguration.Button(
                    tintColor: .primary,
                    pressedTintColor: nil,
                    roleColor: [.destructive: .red, .cancel: .white],
                    padding: EdgeInsets(top: 14, leading: 12, bottom: 14, trailing: 12),
                    accessibilityPadding: EdgeInsets(top: 20, leading: 12, bottom: 20, trailing: 12),
                    font: .body,
                    roleFont: [.cancel: .headline],
                    hideDivider: true,
                    background: .color(Color(.customAlertBackgroundColor)),
                    pressedBackground: .color(Color(.customAlertBackgroundColor)),
                    roleBackground: [.cancel: .color(.accentColor)],
                    spacing: 8,
                    shape: .capsule
                )
            }
        }

        /// The default configuration for a classic alert
        public nonisolated static var classic: CustomAlertConfiguration.Button {
            MainActor.runSync {
                CustomAlertConfiguration.Button(
                    tintColor: nil,
                    pressedTintColor: nil,
                    roleColor: [.destructive: .red],
                    padding: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
                    accessibilityPadding: EdgeInsets(top: 20, leading: 12, bottom: 20, trailing: 12),
                    font: .body,
                    roleFont: [.cancel: .headline],
                    hideDivider: false,
                    background: .color(.almostClear),
                    pressedBackground: .color(Color(.customAlertBackgroundColor)),
                    roleBackground: [:],
                    spacing: 0,
                    shape: .automatic
                )
            }
        }

        public mutating func font(_ font: Font, for role: ButtonRole) {
            guard let type = ButtonType(from: role) else { return }
            self.roleFont[type] = font
        }
        
        public mutating func color(_ color: Color, for role: ButtonRole) {
            guard let type = ButtonType(from: role) else { return }
            self.roleColor[type] = color
        }

        public mutating func background(_ backkground: CustomAlertBackground, for role: ButtonRole) {
            guard let type = ButtonType(from: role) else { return }
            self.roleBackground[type] = backkground
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

private extension UIColor {
    static var customAlertColor: UIColor {
        let traitCollection = UITraitCollection(activeAppearance: .active)
        return .tintColor.resolvedColor(with: traitCollection)
    }
    
    static var customAlertBackgroundColor: UIColor {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                UIColor.white.withAlphaComponent(0.135)
            default:
                UIColor.black.withAlphaComponent(0.085)
            }
        }
    }
}

#Preview {
    CustomAlert(isPresented: .constant(true)) {
        Text("Custom Alert")
    } content: {
        Text("Some Message")
    } actions: {
        MultiButton {
            Button(role: .cancel) {
            } label: {
                Text("Cancel")
            }
            Button {
            } label: {
                Text("OK")
            }
        }
    }
}

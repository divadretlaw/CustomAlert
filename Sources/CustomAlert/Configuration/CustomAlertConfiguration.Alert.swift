//
//  CustomAlertConfiguration.Alert.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI

extension CustomAlertConfiguration {
    /// The custom alert configuration
    public struct Alert: Sendable {
        /// The background of the alert view
        var background: CustomAlertBackground
        /// The visibility of the divider between content and actions
        var dividerVisibility: Visibility
        /// The corner radius of the alert view
        var cornerRadius: CGFloat
        /// The padding of the content of the alert view
        var padding: Value<EdgeInsets>
        /// The padding of the actions of the alert view
        var actionPadding: EdgeInsets
        /// The minimum width of the alert view
        var minWidth: Value<CGFloat>
        /// The default font of the title of the alert view
        var titleFont: Font
        /// The default color of the title of the alert view
        var titleColor: Color
        /// The default font of the content of the alert view
        var contentFont: Font
        /// The default font of the content of the alert view
        var contentColor: Color
        /// The spacing of the content of the alert view
        var spacing: Value<CGFloat>
        /// The alignment of the content of the alert view
        var alignment: CustomAlertAlignment
        /// Optional shadow applied to the alert
        var shadow: CustomAlertShadow?

        // MARK: - Init

        public init() {
            self = .default
        }

        internal init(
            background: CustomAlertBackground,
            dividerVisibility: Visibility,
            cornerRadius: CGFloat,
            padding: Value<EdgeInsets>,
            actionPadding: EdgeInsets,
            minWidth: Value<CGFloat>,
            titleFont: Font,
            titleColor: Color,
            contentFont: Font,
            contentColor: Color,
            spacing: Value<CGFloat>,
            alignment: CustomAlertAlignment,
            shadow: CustomAlertShadow?
        ) {
            self.background = background
            self.dividerVisibility = dividerVisibility
            self.cornerRadius = cornerRadius
            self.padding = padding
            self.actionPadding = actionPadding
            self.minWidth = minWidth
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.contentFont = contentFont
            self.contentColor = contentColor
            self.spacing = spacing
            self.alignment = alignment
            self.shadow = shadow
        }

        /// The default configuration
        nonisolated public static var `default`: CustomAlertConfiguration.Alert {
            if #available(iOS 26.0, visionOS 26.0, *) {
                .liquidGlass
            } else {
                .classic
            }
        }

        // MARK: - Modifier

        /// The background of the alert view
        public func background(_ value: CustomAlertBackground) -> Self {
            var configuration = self
            configuration.background = value
            return configuration
        }

        /// The visibility of the divider between content and actions
        public func dividerVisibility(_ value: Visibility) -> Self {
            var configuration = self
            configuration.dividerVisibility = value
            return configuration
        }

        /// The corner radius of the alert view
        public func cornerRadius(_ value: CGFloat) -> Self {
            var configuration = self
            configuration.cornerRadius = value
            return configuration
        }

        /// The padding of the content of the alert view
        public func padding(_ value: EdgeInsets) -> Self {
            var configuration = self
            configuration.padding = .static(value)
            return configuration
        }

        /// The padding of the actions of the alert view
        public func actionPadding(_ value: EdgeInsets) -> Self {
            var configuration = self
            configuration.actionPadding = value
            return configuration
        }

        /// The minimum width of the alert view
        /// - Parameters:
        ///   - value: The minimum width for the alert.
        ///   - accessibility: The minimum width for the alert when using accessibility scaling.
        public func minWidth(_ value: CGFloat, accessibility: CGFloat? = nil) -> Self {
            var configuration = self
            if let accessibility {
                configuration.minWidth = .dynamic { state in
                    if state.isAccessibilitySize {
                        accessibility
                    } else {
                        value
                    }
                }
            } else {
                configuration.minWidth = .static(value)
            }
            return configuration
        }

        /// The default font of the title of the alert view
        public func titleFont(_ value: Font) -> Self {
            var configuration = self
            configuration.titleFont = value
            return configuration
        }

        /// The default color of the title of the alert view
        public func titleColor(_ value: Color) -> Self {
            var configuration = self
            configuration.titleColor = value
            return configuration
        }

        /// The default font of the content of the alert view
        public func contentFont(_ value: Font) -> Self {
            var configuration = self
            configuration.contentFont = value
            return configuration
        }

        /// The default font of the content of the alert view
        public func contentColor(_ value: Color) -> Self {
            var configuration = self
            configuration.contentColor = value
            return configuration
        }

        /// The spacing of the content of the alert view
        public func spacing(_ value: CGFloat) -> Self {
            var configuration = self
            configuration.spacing = .static(value)
            return configuration
        }

        /// The spacing of the content of the alert view
        public func spacing(_ value: @Sendable @escaping (CustomAlertState) -> CGFloat) -> Self {
            var configuration = self
            configuration.spacing = .dynamic(value)
            return configuration
        }

        /// The alignment of the content of the alert view
        public func alignment(_ value: CustomAlertAlignment) -> Self {
            var configuration = self
            configuration.alignment = value
            return configuration
        }

        /// Optional shadow applied to the alert
        public func shadow(
            color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33),
            radius: CGFloat,
            x: CGFloat = 0,
            y: CGFloat = 0
        ) -> Self {
            var configuration = self
            configuration.shadow = CustomAlertShadow(color: color, radius: radius, x: x, y: y)
            return configuration
        }

        // MARK: - Helper

        var textAlignment: TextAlignment {
            switch alignment {
            case .leading:
                return .leading
            case .trailing:
                return .leading
            case .center:
                return .center
            }
        }

        var horizontalAlignment: HorizontalAlignment {
            switch alignment {
            case .leading:
                return .leading
            case .trailing:
                return .leading
            case .center:
                return .center
            }
        }

        var frameAlignment: Alignment {
            switch alignment {
            case .leading:
                return .leading
            case .trailing:
                return .leading
            case .center:
                return .center
            }
        }
    }
}

/// The alignment of the content of the custom alert
public enum CustomAlertAlignment: Sendable {
    /// The content is aligned in the center
    case center
    /// The content is aligned on the leading edge
    case leading
    /// The content is aligned on the trailing edge
    case trailing
}

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
        public var background: CustomAlertBackground
        /// The corner radius of the alert view
        public var cornerRadius: CGFloat
        /// The padding of the content of the alert view
        public var padding: EdgeInsets
        /// The padding of the content of the alert view when using accessibility scaling
        public var accessibilityPadding: EdgeInsets
        /// The minimum width of the alert view
        public var minWidth: CGFloat
        /// The minimum width of the alert view when using accessibility scaling
        public var accessibilityMinWidth: CGFloat
        /// The default font of the title of the alert view
        public var titleFont: Font
        /// The default font of the content of the alert view
        public var contentFont: Font
        /// The spacing of the content of the alert view
        public var spacing: CGFloat
        /// The alignment of the content of the alert view
        public var alignment: CustomAlertAlignment
        /// Optional shadow applied to the alert
        public var shadow: CustomAlertShadow?

        init(
            background: CustomAlertBackground,
            cornerRadius: CGFloat,
            padding: EdgeInsets,
            accessibilityPadding: EdgeInsets,
            minWidth: CGFloat,
            accessibilityMinWidth: CGFloat,
            titleFont: Font,
            contentFont: Font,
            spacing: CGFloat,
            alignment: CustomAlertAlignment,
            shadow: CustomAlertShadow?
        ) {
            self.background = background
            self.cornerRadius = cornerRadius
            self.padding = padding
            self.accessibilityPadding = accessibilityPadding
            self.minWidth = minWidth
            self.accessibilityMinWidth = accessibilityMinWidth
            self.titleFont = titleFont
            self.contentFont = contentFont
            self.spacing = spacing
            self.alignment = alignment
            self.shadow = shadow
        }

        /// Create a custom configuration
        ///
        /// - Parameter configure: Callback to change the default configuration
        ///
        /// - Returns: The customized ``CustomAlertConfiguration/Alert`` configuration
        public static func create(configure: (inout Self) -> Void) -> Self {
            var configuration = CustomAlertConfiguration.Alert.default
            configure(&configuration)
            return configuration
        }
        
        /// The default configuration
        public nonisolated static var `default`: CustomAlertConfiguration.Alert {
            if #available(iOS 26.0, *) {
                .liquidGlass
            } else {
                .classic
            }
        }

        /// The default configuration for a liquid glass alert
        public nonisolated static var liquidGlass: CustomAlertConfiguration.Alert {
            CustomAlertConfiguration.Alert(
                background: .glass(),
                cornerRadius: 30,
                padding: EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30),
                accessibilityPadding: EdgeInsets(top: 37.5, leading: 12, bottom: 37.5, trailing: 12),
                minWidth: 300,
                accessibilityMinWidth: 379,
                titleFont: .headline,
                contentFont: .callout,
                spacing: 8,
                alignment: .leading,
                shadow: nil
            )
        }

        /// The default configuration for a classic alert
        public nonisolated static var classic: CustomAlertConfiguration.Alert {
            CustomAlertConfiguration.Alert(
                background: .blurEffect(.systemMaterial),
                cornerRadius: 13.3333,
                padding: EdgeInsets(top: 20, leading: 8, bottom: 20, trailing: 8),
                accessibilityPadding: EdgeInsets(top: 37.5, leading: 12, bottom: 37.5, trailing: 12),
                minWidth: 270,
                accessibilityMinWidth: 379,
                titleFont: .headline,
                contentFont: .footnote,
                spacing: 4,
                alignment: .center,
                shadow: nil
            )
        }

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

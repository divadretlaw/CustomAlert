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
        public var contentPadding: EdgeInsets
        /// The padding of the content of the alert view when using accessibility scaling
        public var accessibilityContentPadding: EdgeInsets
        /// The padding of the buttons of the alert view
        public var buttonPadding: EdgeInsets
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
            contentPadding: EdgeInsets,
            accessibilityContentPadding: EdgeInsets,
            buttonPadding: EdgeInsets,
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
            self.contentPadding = contentPadding
            self.buttonPadding = buttonPadding
            self.accessibilityContentPadding = accessibilityContentPadding
            self.minWidth = minWidth
            self.accessibilityMinWidth = accessibilityMinWidth
            self.titleFont = titleFont
            self.contentFont = contentFont
            self.spacing = spacing
            self.alignment = alignment
            self.shadow = shadow
        }

        @available(*, deprecated, renamed: "contentPadding")
        public var padding: EdgeInsets {
            get {
                contentPadding
            }
            set {
                contentPadding = newValue
            }
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
                cornerRadius: 35,
                contentPadding: EdgeInsets(top: 25, leading: 28, bottom: 25, trailing: 28),
                accessibilityContentPadding: EdgeInsets(top: 37.5, leading: 12, bottom: 37.5, trailing: 12),
                buttonPadding: EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15),
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
                contentPadding: EdgeInsets(top: 20, leading: 8, bottom: 20, trailing: 8),
                accessibilityContentPadding: EdgeInsets(top: 37.5, leading: 12, bottom: 37.5, trailing: 12),
                buttonPadding: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
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

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var showAlert = true
    VStack {
        Button("Show Alert") {
            showAlert = true
        }
    }
    .alert("Native Alert", isPresented: $showAlert) {
        Button(role: .cancel) {
        } label: {
            Text("Cancel")
        }
        Button {
        } label: {
            Text("OK")
        }
    } message: {
        Text("Some Message")
    }
    .customAlert("Custom Alert", isPresented: .constant(true)) {
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

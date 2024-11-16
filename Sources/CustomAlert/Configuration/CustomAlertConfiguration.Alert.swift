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
        
        init() {
            self.background = .blurEffect(.systemMaterial)
            self.cornerRadius = 13.3333
            self.padding = EdgeInsets(top: 20, leading: 8, bottom: 20, trailing: 8)
            self.accessibilityPadding = EdgeInsets(top: 37.5, leading: 12, bottom: 37.5, trailing: 12)
            self.minWidth = 270
            self.accessibilityMinWidth = 329
            self.titleFont = .headline
            self.contentFont = .footnote
            self.spacing = 4
            self.alignment = .center
            self.shadow = nil
        }
        
        /// Create a custom configuration
        ///
        /// - Parameter configure: Callback to change the default configuration
        ///
        /// - Returns: The customized ``CustomAlertConfiguration/Alert`` configuration
        public static func create(configure: (inout Self) -> Void) -> Self {
            var configuration = Self()
            configure(&configuration)
            return configuration
        }
        
        /// The default configuration
        @MainActor public static var `default`: CustomAlertConfiguration {
            CustomAlertConfiguration()
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

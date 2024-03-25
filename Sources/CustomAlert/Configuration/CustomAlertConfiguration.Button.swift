//
//  CustomAlertConfiguration.Button.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI

extension CustomAlertConfiguration {
    public struct Button {
        /// The tint color of the alert button
        public var tintColor: Color? = nil
        internal var roleColor: [ButtonType: Color] = [:]
        /// The padding of the alert button
        public var padding: EdgeInsets = EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        /// The font of the alert button
        public var font: Font = .body
        internal var roleFont: [ButtonType: Font] = [.cancel: .headline]
        /// Whether to hide the dividers between the buttons
        public var hideDivider: Bool = false
        /// Override the button style if needed
        ///
        /// > Note:
        /// > Make sure to use `@Environment(\.alertDismiss)` to dismiss the button when using a custom `ButtonStyle`
        public var buttonStyle: (any ButtonStyle)?
        
        @available(iOS 15.0, *)
        mutating func font(_ font: Font, for role: ButtonRole) {
            guard let type = ButtonType(from: role) else { return }
            self.roleFont[type] = font
        }
        
        @available(iOS 15.0, *)
        mutating func color(_ color: Color, for role: ButtonRole) {
            guard let type = ButtonType(from: role) else { return }
            self.roleColor[type] = color
        }
        
        /// Create a custom configuration
        /// 
        /// - Parameter configure: Callback to change the default configuration
        ///
        /// - Returns: The customized ``CustomAlertConfiguration/Button`` configuration
        public static func create(configure: (inout Self) -> Void) -> Self {
            var configuration = Self()
            configure(&configuration)
            return configuration
        }
        
        /// The default configuration
        public static var `default`: Self {
            Self()
        }
    }
}

/// Internal button type because `ButtonRole` is iOS 15+
enum ButtonType: Hashable {
    case destructive
    case cancel
    
    @available(iOS 15.0, *)
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

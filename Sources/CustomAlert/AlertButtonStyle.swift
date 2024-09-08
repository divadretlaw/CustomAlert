//
//  AlertButtonStyle.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI
import WindowReader

/// A button style that applies standard alert styling
///
/// You can also use ``alert`` to construct this style.
public struct AlertButtonStyle: ButtonStyle {
    @Environment(\.customAlertConfiguration.button) private var buttonConfiguration
    @Environment(\.alertDismiss) private var alertDismiss
    @Environment(\.alertButtonHeight) private var maxHeight
    @Environment(\.customDynamicTypeSize) private var dynamicTypeSize
    
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.window) private var window
    
    var triggerDismiss: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        if triggerDismiss {
            makeLabel(configuration: configuration)
                .onSimultaneousTapGesture {
                    alertDismiss()
                }
        } else {
            makeLabel(configuration: configuration)
        }
    }
    
    func makeLabel(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            label(configuration: configuration)
                .lineLimit(0)
                .minimumScaleFactor(0.66)
                .truncationMode(.middle)
            Spacer()
        }
        .padding(padding)
        .frame(maxHeight: maxHeight)
        .background(background(configuration: configuration))
    }
    
    var padding: EdgeInsets {
        if dynamicTypeSize.isAccessibilitySize {
            buttonConfiguration.accessibilityPadding
        } else {
            buttonConfiguration.padding
        }
    }
    
    @ViewBuilder func label(configuration: Configuration) -> some View {
        if #available(iOS 15, *) {
            switch configuration.role {
            case .some(.destructive):
                configuration.label
                    .font(resolvedFont(role: .destructive))
                    .foregroundColor(resolvedColor(role: .destructive, isPressed: configuration.isPressed))
            case .some(.cancel):
                configuration.label
                    .font(resolvedFont(role: .cancel))
                    .foregroundColor(resolvedColor(role: .cancel, isPressed: configuration.isPressed))
            default:
                configuration.label
                    .font(resolvedFont())
                    .foregroundColor(resolvedColor(isPressed: configuration.isPressed))
            }
        } else {
            configuration.label
                .font(resolvedFont())
                .foregroundColor(resolvedColor(isPressed: configuration.isPressed))
        }
    }
    
    @ViewBuilder func background(configuration: Self.Configuration) -> some View {
        if configuration.isPressed {
            BackgroundView(background: buttonConfiguration.pressedBackground)
        } else {
            BackgroundView(background: buttonConfiguration.background)
        }
    }
    
    func resolvedColor(role: ButtonType? = nil, isPressed: Bool) -> Color {
        if isEnabled {
            if isPressed, let color = buttonConfiguration.pressedTintColor {
                return color
            } else if let role, let color = buttonConfiguration.roleColor[role] {
                return color
            } else if let color = buttonConfiguration.tintColor {
                return color
            }
            
            // Fallback
            guard let color = window?.tintColor else {
                return .accentColor
            }
            
            if #available(iOS 15.0, *) {
                return Color(uiColor: color)
            } else {
                return Color(color)
            }
        } else {
            return Color("Disabled", bundle: .module)
        }
    }
    
    func resolvedFont(role: ButtonType? = nil) -> Font {
        if let role, let font = buttonConfiguration.roleFont[role] {
            return font
        } else {
            return buttonConfiguration.font
        }
    }
}

public extension ButtonStyle where Self == AlertButtonStyle {
    /// A button style that applies standard alert styling
    ///
    /// A tap on the button will trigger `EnvironmentValues.alertDismiss`
    static var alert: Self {
        AlertButtonStyle(triggerDismiss: true)
    }
    
    /// A button style that applies standard alert styling
    ///
    /// - Parameter triggerDismiss: Whether the button should trigger `EnvironmentValues.alertDismiss` or not.
    static func alert(triggerDismiss: Bool) -> Self {
        AlertButtonStyle(triggerDismiss: triggerDismiss)
    }
}

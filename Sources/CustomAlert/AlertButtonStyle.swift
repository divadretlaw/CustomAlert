//
//  AlertButtonStyle.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI

/// A button style that applies standard alert styling
///
/// You can also use ``alert`` to construct this style.
public struct AlertButtonStyle: ButtonStyle {
    @Environment(\.customAlertConfiguration.button) private var buttonConfiguration
    @Environment(\.alertDismiss) private var alertDismiss
    @Environment(\.alertButtonHeight) private var maxHeight
    
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.window) private var window
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Spacer()
            label(configuration: configuration)
                .lineLimit(0)
                .minimumScaleFactor(0.66)
                .truncationMode(.middle)
            Spacer()
        }
        .padding(buttonConfiguration.padding)
        .frame(maxHeight: maxHeight)
        .background(background(configuration: configuration))
        .onSimultaneousTapGesture {
            alertDismiss()
        }
    }
    
    @ViewBuilder func label(configuration: Self.Configuration) -> some View {
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
    /// To apply this style to a button, or to a view that contains buttons, use
    /// the `View/buttonStyle(_:)` modifier.
    static var alert: Self {
        AlertButtonStyle()
    }
}

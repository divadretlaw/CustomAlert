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
    
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.alertButtonHeight) private var maxHeight
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
    }
    
    @ViewBuilder func label(configuration: Self.Configuration) -> some View {
        if #available(iOS 15, *) {
            switch configuration.role {
            case .some(.destructive):
                configuration.label
                    .font(buttonConfiguration.roleFont[.destructive] ?? buttonConfiguration.font)
                    .foregroundColor(buttonConfiguration.roleColor[.destructive] ?? color)
            case .some(.cancel):
                configuration.label
                    .font(buttonConfiguration.roleFont[.cancel] ?? buttonConfiguration.font)
                    .foregroundColor(buttonConfiguration.roleColor[.cancel] ?? color)
            default:
                configuration.label
                    .font(buttonConfiguration.font)
                    .foregroundColor(color)
            }
        } else {
            configuration.label
                .font(buttonConfiguration.font)
                .foregroundColor(color)
        }
    }
    
    @ViewBuilder
    func background(configuration: Self.Configuration) -> some View {
        if configuration.isPressed {
            switch colorScheme {
            case .dark:
                Color.white.opacity(0.135)
            case .light:
                Color.black.opacity(0.085)
            @unknown default:
                Color.primary.opacity(0.085)
            }
        } else {
            Color.almostClear
        }
    }
    
    var color: Color {
        if isEnabled {
            if let color = buttonConfiguration.tintColor {
                return color
            }
            
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

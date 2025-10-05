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
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.window) private var window

    public func makeBody(configuration: Configuration) -> some View {
        makeLabel(configuration: configuration)
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
        .padding(buttonConfiguration.padding(state))
        .frame(maxHeight: maxHeight)
        .background(background(configuration: configuration))
        .alertButtonBorderShape(buttonConfiguration.shape)
        .fixedSize(horizontal: false, vertical: true)
    }

    var state: CustomAlertState {
        CustomAlertState(dynamicTypeSize: dynamicTypeSize, isScrolling: false)
    }

    @ViewBuilder func label(configuration: Configuration) -> some View {
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
    }

    func background(configuration: Self.Configuration) -> some View {
        ZStack {
            switch configuration.role {
            case .some(.destructive):
                BackgroundView(background: resolvedBackground(role: .destructive))
            case .some(.cancel):
                BackgroundView(background: resolvedBackground(role: .cancel))
            default:
                BackgroundView(background: resolvedBackground())
            }
            if configuration.isPressed {
                BackgroundView(background: buttonConfiguration.pressedBackground)
            }
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

            return Color(uiColor: color)
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

    func resolvedBackground(role: ButtonType? = nil) -> CustomAlertBackground {
        if let role, let background = buttonConfiguration.roleBackground[role] {
            return background
        } else {
            return buttonConfiguration.background
        }
    }
}

public extension ButtonStyle where Self == AlertButtonStyle {
    /// A button style that applies standard alert styling
    ///
    /// A tap on the button will trigger `EnvironmentValues.alertDismiss`
    static var alert: Self {
        AlertButtonStyle()
    }

    /// A button style that applies standard alert styling
    ///
    /// - Parameter triggerDismiss: Whether the button should trigger `EnvironmentValues.alertDismiss` or not.
    @available(*, deprecated, message: "")
    static func alert(triggerDismiss: Bool) -> Self {
        AlertButtonStyle()
    }
}

#Preview("OK") {
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

#Preview("Destructive") {
    CustomAlert(isPresented: .constant(true)) {
        Text("Custom Alert")
    } content: {
        Text("Some Message")
    } actions: {
        Button(role: .destructive) {
        } label: {
            Text("Delete")
        }
        Button(role: .cancel) {
        } label: {
            Text("Cancel")
        }
    }
}

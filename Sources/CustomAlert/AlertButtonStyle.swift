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
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.alertButtonHeight) var maxHeight
    @Environment(\.window) var window
    
    @Binding var isPresented: Bool
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Spacer()
            label(configuration: configuration)
                .lineLimit(0)
                .minimumScaleFactor(0.66)
                .truncationMode(.middle)
            Spacer()
        }
        .padding(12)
        .frame(maxHeight: maxHeight)
        .background(background(configuration: configuration))
        .simultaneousGesture(TapGesture().onEnded { _ in
            guard isEnabled else { return }
            isPresented = false
        })
    }
    
    @ViewBuilder
    func label(configuration: Self.Configuration) -> some View {
        if #available(iOS 15, *) {
            switch configuration.role {
            case .some(.destructive):
                configuration.label
                    .font(.body)
                    .foregroundColor(.red)
            case .some(.cancel):
                configuration.label
                    .font(.headline)
                    .foregroundColor(color)
            default:
                configuration.label
                    .font(.body)
                    .foregroundColor(color)
            }
        } else {
            configuration.label
                .font(.body)
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
        AlertButtonStyle(isPresented: .constant(true))
    }
}

public extension ButtonStyle where Self == AlertButtonStyle {
    /// A button style that applies standard alert styling
    ///
    /// To apply this style to a button, or to a view that contains buttons, use
    /// the `View/buttonStyle(_:)` modifier.
    static func alert(isPresented: Binding<Bool>) -> Self {
        AlertButtonStyle(isPresented: isPresented)
    }
}

struct AlertButtonHeightKey: EnvironmentKey {
    static var defaultValue: CGFloat? {
        nil
    }
}

extension EnvironmentValues {
    var alertButtonHeight: CGFloat? {
        get {
            self[AlertButtonHeightKey.self]
        }
        set {
            self[AlertButtonHeightKey.self] = newValue
        }
    }
}

//
//  AlertButtonStyle.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI

public struct AlertButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
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
        .frame(maxHeight: .infinity)
        .background(background(configuration: configuration))
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
                    .foregroundColor(.accentColor)
            default:
                configuration.label
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        } else {
            configuration.label
                .font(.body)
                .foregroundColor(.accentColor)
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
}

extension ButtonStyle where Self == AlertButtonStyle {
    public static var alert: Self {
        AlertButtonStyle()
    }
}


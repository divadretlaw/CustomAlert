//
//  AlertButtonStyle.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI

struct AlertButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Spacer()
            label(configuration: configuration)
                .lineLimit(0)
                .minimumScaleFactor(0.66)
                .truncationMode(.middle)
            Spacer()
        }
        .padding(12)
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
            Color.black.opacity(0.08)
        } else {
            Color.almostClear
        }
    }
}

extension ButtonStyle where Self == AlertButtonStyle {
    static var alert: Self {
        AlertButtonStyle()
    }
}

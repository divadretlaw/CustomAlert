//
//  BackgroundView.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.customAlertConfiguration) private var configuration

    var background: CustomAlertBackground

    var body: some View {
        switch background {
        case .blurEffect(let style):
            BlurView(style: style)
        case .color(let color):
            color
        case .colorBlurEffect(let color, let style):
            ZStack {
                color
                BlurView(style: style)
            }
        case .anyView(let view):
            view
        case .glass(let color):
            #if swift(>=6.2) && !os(visionOS)
            if #available(iOS 26.0, *) {
                Color.clear.glassEffect(.regular.tint(color), in: RoundedRectangle(cornerRadius: configuration.alert.cornerRadius))
            } else {
                if let color {
                    ZStack {
                        color
                        BlurView(style: .systemMaterial)
                    }
                } else {
                    BlurView(style: .systemMaterial)
                }
            }
            #else
            if let color {
                ZStack {
                    color
                    BlurView(style: .systemMaterial)
                }
            } else {
                BlurView(style: .systemMaterial)
            }
            #endif
        }
    }
}

#Preview {
    VStack {
        BackgroundView(background: .blurEffect(.regular))
        BackgroundView(background: .color(.blue))
        BackgroundView(background: .colorBlurEffect(.blue, .regular))
        BackgroundView(background: .view {
            ZStack {
                Color.green
                Text("Test")
            }
        })
    }
}

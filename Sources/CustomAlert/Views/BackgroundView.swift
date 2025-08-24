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
        case let .blurEffect(style):
            BlurView(style: style)
        case let .color(color):
            color
        case let .colorBlurEffect(color, style):
            ZStack {
                color
                BlurView(style: style)
            }
        case let .anyView(view):
            view
        case let .glass(color):
            #if swift(>=6.2)
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

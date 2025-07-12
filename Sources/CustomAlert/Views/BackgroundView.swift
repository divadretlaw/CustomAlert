//
//  BackgroundView.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import SwiftUI

struct BackgroundView: View {
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
            if #available(iOS 26.0, *) {
                /// UIGlassEffect doesn't support custom radius yet: https://developer.apple.com/forums/thread/787996?answerId=843646022#843646022
                // GlassView(color: color)
                BlurView(style: .systemMaterial)
            } else {
                if let color {
                    ZStack {
                        Color(uiColor: color)
                        BlurView(style: .systemMaterial)
                    }
                } else {
                    BlurView(style: .systemMaterial)
                }
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
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

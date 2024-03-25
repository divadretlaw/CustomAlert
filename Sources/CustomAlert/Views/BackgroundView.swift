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
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(background: .blurEffect(.regular))
        BackgroundView(background: .color(.blue))
        BackgroundView(background: .colorBlurEffect(.blue, .regular))
    }
}

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
        case .blurEffect(let style):
            BlurView(style: style)
        case .color(let color):
            color
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(background: .blurEffect(.regular))
        BackgroundView(background: .color(.blue))
    }
}

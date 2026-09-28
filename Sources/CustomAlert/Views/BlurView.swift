//
//  BlurView.swift
//  CustomAlert
//
//  Created by David Walter on 31.03.24.
//

import SwiftUI

struct BlurView: View {
    let style: Material

    var body: some View {
        Color.clear.background(style)
    }
}

#Preview {
    VStack(spacing: 8) {
        BlurView(style: .regular)
        BlurView(style: .bar)
        BlurView(style: .thin)
        BlurView(style: .thick)
    }
    .background(.tint)
    .ignoresSafeArea()
}

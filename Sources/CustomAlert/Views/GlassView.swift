//
//  BlurView.swift
//  CustomAlert
//
//  Created by David Walter on 31.03.24.
//

import SwiftUI

// Using UIViewRepresentable BlurView for backwards compatibility
@available(iOS 26.0, *)
struct GlassView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let glassEffect = UIGlassEffect()
        let glassView = UIVisualEffectView(effect: glassEffect)
        glassView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(glassView, at: 0)
        NSLayoutConstraint.activate([
            glassView.heightAnchor.constraint(equalTo: view.heightAnchor),
            glassView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // empty
    }
}

@available(iOS 26.0, *)
#Preview {
    GlassView()
}

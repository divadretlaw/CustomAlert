//
//  Helpers.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI
import Combine

// MARK: - Color

extension Color {
    static var almostClear: Color {
        Color.black.opacity(0.0001)
    }
}

// MARK: - Capture Size

struct IntrinsicContentSizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func captureSize(_ size: Binding<CGSize>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: IntrinsicContentSizePreferenceKey.self, value: proxy.size)
                    .onPreferenceChange(IntrinsicContentSizePreferenceKey.self) {
                        size.wrappedValue = $0
                    }
            }
        )
    }
}

// MARK: - Blur View

// Using UIViewRepresentable BlurView for backwards compatibility
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }
}

// MARK: - ScrollView disabled

extension View {
    func scrollViewDisabled(_ disabled: Bool) -> some View {
        modifier(DisabledViewModifier(isDisabled: disabled))
    }
}

private struct DisabledViewModifier: ViewModifier {
    var isDisabled: Bool
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollDisabled(isDisabled)
        } else {
            content.disabled(isDisabled)
        }
    }
}

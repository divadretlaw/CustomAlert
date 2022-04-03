//
//  Helpers.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI
import Combine

// MARK: - onUpdate

extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder
    func onUpdate<T: Equatable>(of value: T, perform onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { value in
                onChange(value)
            }
        }
    }
}

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

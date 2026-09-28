//
//  CaptureSize.swift
//  CustomAlert
//
//  Created by David Walter on 31.03.24.
//

import SwiftUI

private struct IntrinsicContentSizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private struct IntrinsicSafeAreaPreferenceKey: PreferenceKey {
    static let defaultValue: EdgeInsets = .zero

    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {
        value = nextValue()
    }
}

extension View {
    func captureSize(_ size: Binding<CGSize>) -> some View {
        captureSize { anchor, proxy in
            anchor
                .preference(key: IntrinsicContentSizePreferenceKey.self, value: proxy.size)
                .onPreferenceChange(IntrinsicContentSizePreferenceKey.self) {
                    size.wrappedValue = $0
                }
        }
    }

    func captureTotalSize(_ size: Binding<CGSize>) -> some View {
        captureSize { anchor, proxy in
            anchor
                .preference(key: IntrinsicContentSizePreferenceKey.self, value: proxy.size)
                .onPreferenceChange(IntrinsicContentSizePreferenceKey.self) {
                    size.wrappedValue = $0 + proxy.safeAreaInsets
                }
                .preference(key: IntrinsicSafeAreaPreferenceKey.self, value: proxy.safeAreaInsets)
                .onPreferenceChange(IntrinsicSafeAreaPreferenceKey.self) {
                    size.wrappedValue = proxy.size + $0
                }
        }
    }

    func captureSafeAreaInsets(_ safeArea: Binding<EdgeInsets>) -> some View {
        captureSize { anchor, proxy in
            anchor
                .preference(key: IntrinsicSafeAreaPreferenceKey.self, value: proxy.safeAreaInsets)
                .onPreferenceChange(IntrinsicSafeAreaPreferenceKey.self) {
                    safeArea.wrappedValue = $0
                }
        }
    }
}

private extension View {
    func captureSize<Result>(
        @ViewBuilder builder: @escaping (_ anchor: AnyView, _ proxy: SendableGeometryProxy) -> Result
    ) -> some View where Result: View {
        modifier(CaptureSize(builder: builder))
    }
}

private struct CaptureSize<Result>: ViewModifier where Result: View {
    let builder: (_ anchor: AnyView, _ proxy: SendableGeometryProxy) -> Result

    init(
        @ViewBuilder builder: @escaping (_ anchor: AnyView, _ proxy: SendableGeometryProxy) -> Result
    ) {
        self.builder = builder
    }

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    builder(AnyView(Color.clear), SendableGeometryProxy(proxy: proxy))
                }
            }
    }
}

private struct SendableGeometryProxy: Sendable {
    let size: CGSize
    let safeAreaInsets: EdgeInsets

    init(proxy: GeometryProxy) {
        self.size = proxy.size
        self.safeAreaInsets = proxy.safeAreaInsets
    }
}

private extension CGSize {
    static func + (lhs: CGSize, rhs: EdgeInsets) -> CGSize {
        let width = lhs.width + rhs.leading + rhs.trailing
        let height = lhs.height + rhs.top + rhs.bottom
        return CGSize(width: width, height: height)
    }
}

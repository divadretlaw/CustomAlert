//
//  CustomAlertBackground.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI

/// Wrapped background of the alert
public enum CustomAlertBackground: Sendable {
    /// A `Color` as background
    case color(Color)
    /// Any view a background
    case anyView(AnyView)
    /// Liquid glass as background
    case glass(Color? = nil)
    /// A `Material` as background
    case blurEffect(Material)
    /// A `Material` as background with a `Color` as background
    case colorBlurEffect(Color, Material)

    @MainActor public static func view<Content>(@ViewBuilder builder: () -> Content) -> CustomAlertBackground where Content: View {
        CustomAlertBackground.anyView(AnyView(builder: builder))
    }

    @MainActor public static func view<Content>(_ view: Content) -> CustomAlertBackground where Content: View {
        CustomAlertBackground.anyView(AnyView(view))
    }

    @MainActor public struct AnyView: View, Sendable {
        let wrappedView: SwiftUI.AnyView

        init<Content>(@ViewBuilder builder: () -> Content) where Content: View {
            self.wrappedView = SwiftUI.AnyView(builder())
        }

        init<Content>(_ view: Content) where Content: View {
            self.wrappedView = SwiftUI.AnyView(view)
        }

        public var body: some View {
            wrappedView
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        BackgroundView(background: .color(.red))
        BackgroundView(background: .glass())
        BackgroundView(background: .blurEffect(.regular))
        BackgroundView(background: .colorBlurEffect(.red, .regular))
    }
    .background(.tint)
    .ignoresSafeArea()
}

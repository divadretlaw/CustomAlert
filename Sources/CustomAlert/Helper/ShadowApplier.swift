//
//  ShadowApplier.swift
//  CustomAlert
//
//  Created by David Walter on 16.11.24.
//

import SwiftUI

extension View {
    func shadow(_ shadow: CustomAlertShadow?) -> some View {
        modifier(ShadowApplier(shadow: shadow))
    }
}

private struct ShadowApplier: ViewModifier {
    let shadow: CustomAlertShadow?

    func body(content: Content) -> some View {
        if let shadow {
            content.shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
        } else {
            content
        }
    }
}

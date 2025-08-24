//
//  BorderShapeApplier.swift
//  CustomAlert
//
//  Created by David Walter on 12.07.25.
//

import SwiftUI

extension View {
    func alertButtonBorderShape(_ shape: ButtonBorderShape) -> some View {
        modifier(BorderShapeApplier(shape: shape))
    }
}

private struct BorderShapeApplier: ViewModifier {
    let shape: ButtonBorderShape

    func body(content: Content) -> some View {
        switch shape {
        case .capsule:
            content.clipShape(Capsule())
        case .roundedRectangle:
            content.clipShape(RoundedRectangle(cornerRadius: 8))
        default:
            content
        }
    }
}

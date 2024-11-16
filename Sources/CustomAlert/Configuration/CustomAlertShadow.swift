//
//  CustomAlertShadow.swift
//  CustomAlert
//
//  Created by David Walter on 16.11.24.
//

import SwiftUI

/// Shadow configuration of the alert
public struct CustomAlertShadow: Sendable {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    /// Create a custom alert shadow
    ///
    /// - Parameters:
    ///   - color: The shadow's color.
    ///   - radius: A measure of how much to blur the shadow. Larger values
    ///     result in more blur.
    ///   - x: An amount to offset the shadow horizontally from the view.
    ///   - y: An amount to offset the shadow vertically from the view.
    public init(
        color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33),
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

//
//  CustomAlertBackground.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI
import UIKit

/// Wrapped background of the alert
public enum CustomAlertBackground {
    /// A `UIBlurEffect` as background
    case blurEffect(UIBlurEffect.Style)
    /// A `Color` as background
    case color(Color)
    /// A `UIBlurEffect` as background with a `Color` as background
    case colorBlurEffect(Color, UIBlurEffect.Style)
    case anyView(AnyView)
    
    public static func view<Content>(@ViewBuilder builder: () -> Content) -> CustomAlertBackground where Content: View {
        CustomAlertBackground.anyView(AnyView(builder()))
    }
    
    public static func view<Content>(_ view: Content) -> CustomAlertBackground where Content: View {
        CustomAlertBackground.anyView(AnyView(view))
    }
}

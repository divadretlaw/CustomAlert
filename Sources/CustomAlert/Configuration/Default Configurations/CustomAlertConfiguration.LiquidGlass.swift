//
//  CustomAlertConfiguration.LiquidGlass.swift
//  CustomAlert
//
//  Created by David Walter on 08.11.25.
//

import Foundation
import SwiftUI

extension CustomAlertConfiguration {
    /// The default configuration for a liquid glass alert
    @available(iOS 26.0, visionOS 26.0, *)
    nonisolated public static var liquidGlass: CustomAlertConfiguration {
        MainActor.runSync {
            CustomAlertConfiguration(
                alert: .liquidGlass,
                button: .liquidGlass,
                background: .color(Color("DimmingBackround", bundle: .module)),
                padding: EdgeInsets(top: 11, leading: 20, bottom: 11, trailing: 20),
                transition: .opacity.combined(with: .scale(scale: 1.1)),
                animateTransition: true,
                alignment: .center,
                dismissOnBackgroundTap: false
            )
        }
    }
}

extension CustomAlertConfiguration.Alert {
    /// The default configuration for a liquid glass alert
    @available(iOS 26.0, visionOS 26.0, *)
    nonisolated public static var liquidGlass: CustomAlertConfiguration.Alert {
        CustomAlertConfiguration.Alert(
            background: .glass(),
            dividerVisibility: .automatic,
            cornerRadius: 35,
            padding: .dynamic { state in
                let top: CGFloat = if state.isScrolling {
                    4
                } else if state.isAccessibilitySize {
                    37.5
                } else {
                    22
                }

                return EdgeInsets(
                    top: top,
                    leading: 30,
                    bottom: 5,
                    trailing: 30
                )
            },
            actionPadding: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
            minWidth: .dynamic { state in
                if state.isAccessibilitySize {
                    379
                } else {
                    320
                }
            },
            titleFont: .headline,
            titleColor: .primary,
            contentFont: .subheadline,
            contentColor: .secondary,
            spacing: .dynamic { state in
                if state.isScrolling {
                    0
                } else if state.isAccessibilitySize {
                    30
                } else {
                    8
                }
            },
            alignment: .leading,
            shadow: nil
        )
    }
}

extension CustomAlertConfiguration.Button {
    /// The default configuration for a liquid glass alert
    @available(iOS 26.0, visionOS 26.0, *)
    nonisolated public static var liquidGlass: CustomAlertConfiguration.Button {
        MainActor.runSync {
            CustomAlertConfiguration.Button(
                tintColor: .primary,
                pressedTintColor: nil,
                roleColor: [.destructive: .red],
                padding: .dynamic { state in
                    if state.isAccessibilitySize {
                        EdgeInsets(top: 20, leading: 12, bottom: 20, trailing: 12)
                    } else {
                        EdgeInsets(top: 14, leading: 12, bottom: 14, trailing: 12)
                    }
                },
                font: .body.weight(.medium),
                roleFont: [:],
                hideDivider: true,
                background: .color(Color("Background", bundle: .module)),
                pressedBackground: .color(.liquidGlassBackgroundColor),
                roleBackground: [:],
                spacing: 8,
                shape: .capsule
            )
        }
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("Default") {
    AlertPreview(title: "Title", content: "Content")
}

@available(iOS 17.0, *)
#Preview("Lorem Ipsum") {
    AlertPreview(title: "Title", content: .loremIpsum)
}
#endif

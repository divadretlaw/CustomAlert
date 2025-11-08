//
//  CustomAlertConfiguration.Clasic.swift
//  CustomAlert
//
//  Created by David Walter on 08.11.25.
//

import Foundation
import SwiftUI

extension CustomAlertConfiguration {
    /// The default configuration for a classic alert
    nonisolated public static var classic: CustomAlertConfiguration {
        MainActor.runSync {
            CustomAlertConfiguration(
                alert: .classic,
                button: .classic,
                background: .color(Color("DimmingBackround", bundle: .module)),
                padding: EdgeInsets(top: 11, leading: 30, bottom: 11, trailing: 30),
                transition: .opacity.combined(with: .scale(scale: 1.1)),
                animateTransition: true,
                alignment: .center,
                dismissOnBackgroundTap: false
            )
        }
    }
}

extension CustomAlertConfiguration.Alert {
    /// The default configuration for a classic alert
    nonisolated public static var classic: CustomAlertConfiguration.Alert {
        CustomAlertConfiguration.Alert(
            background: .blurEffect(.systemThinMaterial),
            dividerVisibility: .visible,
            cornerRadius: 13.3333,
            padding: .dynamic { state in
                let top: CGFloat = if state.isScrolling {
                    4
                } else if state.isAccessibilitySize {
                    37.5
                } else {
                    20
                }

                let horizontal: CGFloat = if state.isAccessibilitySize {
                    12
                } else {
                    8
                }

                let bottom: CGFloat = if state.isScrolling {
                    4
                } else if state.isAccessibilitySize {
                    12
                } else {
                    20
                }

                return EdgeInsets(
                    top: top,
                    leading: horizontal,
                    bottom: bottom,
                    trailing: horizontal
                )
            },
            actionPadding: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
            minWidth: .dynamic { state in
                if state.isAccessibilitySize {
                    379
                } else {
                    270
                }
            },
            titleFont: .headline,
            titleColor: .primary,
            contentFont: .footnote,
            contentColor: .primary,
            spacing: .dynamic { state in
                if state.isAccessibilitySize {
                    0
                } else {
                    4
                }
            },
            alignment: .center,
            shadow: nil
        )
    }
}

extension CustomAlertConfiguration.Button {
    /// The default configuration for a classic alert
    nonisolated public static var classic: CustomAlertConfiguration.Button {
        MainActor.runSync {
            CustomAlertConfiguration.Button(
                tintColor: nil,
                pressedTintColor: nil,
                roleColor: [.destructive: .red],
                padding: .dynamic { state in
                    if state.isAccessibilitySize {
                        EdgeInsets(top: 20, leading: 12, bottom: 20, trailing: 12)
                    } else {
                        EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
                    }
                },
                font: .body,
                roleFont: [.cancel: .headline],
                hideDivider: false,
                background: .color(.almostClear),
                pressedBackground: .color(.classicBackgroundColor),
                roleBackground: [:],
                spacing: 0,
                shape: .automatic
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

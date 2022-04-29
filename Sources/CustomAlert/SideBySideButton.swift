//
//  SideBySideButton.swift
//  CustomAlert
//
//  Created by David Walter on 29.04.22.
//

import SwiftUI

/// A control that initiates an two actions. One left and one right
///
/// Used to create side by side buttons on the `.customAlert`
public struct SideBySideButton<LeftContent, RightContent>: View where LeftContent: View, RightContent: View {
    var buttonLeft: Button<LeftContent>
    var buttonRight: Button<RightContent>
    
    public var body: some View {
        HStack(spacing: 0) {
            buttonLeft
                .frame(maxWidth: .infinity)
            Divider()
            buttonRight
                .frame(maxWidth: .infinity)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    /// Creates two buttons with the specified roles that displays custom labels.
    ///
    /// - Parameters:
    ///   - roleLeft: An optional semantic role that describes the left button. A value of
    ///     `nil` means that the left button doesn't have an assigned role.
    ///   - roleRight: An optional semantic role that describes the right button. A value of
    ///     `nil` means that the right button doesn't have an assigned role.
    ///   - actionLeft: The action to perform when the user interacts with the left button.
    ///   - actionRight: The action to perform when the user interacts with the right button.
    ///   - labelLeft: A view that describes the purpose of the left button's `action`.
    ///   - labelRight: A view that describes the purpose of the right button's `action`.
    @available(iOS 15, *)
    public init(roleLeft: ButtonRole? = nil,
                roleRight: ButtonRole? = nil,
                actionLeft: @escaping () -> Void,
                actionRight: @escaping () -> Void,
                @ViewBuilder labelLeft: @escaping () -> LeftContent,
                @ViewBuilder labelRight: @escaping () -> RightContent) {
        self.buttonLeft = Button(role: roleLeft, action: actionLeft, label: labelLeft)
        self.buttonRight = Button(role: roleRight, action: actionRight, label: labelRight)
    }
    
    /// Creates two buttons that displays custom labels.
    ///
    /// - Parameters:
    ///   - actionLeft: The action to perform when the user interacts with the left button.
    ///   - actionRight: The action to perform when the user interacts with the right button.
    ///   - labelLeft: A view that describes the purpose of the left button's `action`.
    ///   - labelRight: A view that describes the purpose of the right button's `action`.
    public init(actionLeft: @escaping () -> Void,
                actionRight: @escaping () -> Void,
                @ViewBuilder labelLeft: @escaping () -> LeftContent,
                @ViewBuilder labelRight: @escaping () -> RightContent) {
        self.buttonLeft = Button(action: actionLeft, label: labelLeft)
        self.buttonRight = Button(action: actionRight, label: labelRight)
    }
}

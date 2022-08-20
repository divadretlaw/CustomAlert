//
//  SideBySideButton.swift
//  CustomAlert
//
//  Created by David Walter on 29.04.22.
//

import SwiftUI

/// A control that wraps multiple actions horizontally.
///
/// Used to create side by side buttons on a `.customAlert`
public struct MultiButton<Content>: View where Content: View {
    @ViewBuilder public var content: () -> Content
    
    public var body: some View {
        _VariadicView.Tree(ContentLayout(), content: content)
    }
    
    /// Creates multiple buttons within the MultiButton Layout.
    ///
    /// - Parameters:
    ///   - content: The `ViewBuilder` with multiple `Button`s
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    struct ContentLayout: _VariadicView_ViewRoot {
        func body(children: _VariadicView.Children) -> some View {
            HStack(spacing: 0) {
                children.first
                ForEach(children.dropFirst()) { child in
                    Divider()
                    child
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .buttonStyle(.alert)
            .environment(\.alertButtonHeight, .infinity)
        }
    }
}

/// A control that initiates two actions. One left and one right
///
/// Used to create side by side buttons on a `.customAlert`
@available(*, deprecated, message: "Prefer using `MultiButton` instead.")
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
        .buttonStyle(.alert)
        .environment(\.alertButtonHeight, .infinity)
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
    @_disfavoredOverload public init(actionLeft: @escaping () -> Void,
                actionRight: @escaping () -> Void,
                @ViewBuilder labelLeft: @escaping () -> LeftContent,
                @ViewBuilder labelRight: @escaping () -> RightContent) {
        self.buttonLeft = Button(action: actionLeft, label: labelLeft)
        self.buttonRight = Button(action: actionRight, label: labelRight)
    }
}

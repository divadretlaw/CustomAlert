//
//  Button.swift
//  CustomAlert
//
//  Created by David Walter on 05.10.25.
//

import SwiftUI

/// A control that initiates a custom alert action.
@MainActor public struct Button: View {
    @Environment(\.alertDismiss) private var alertDismiss
    @Environment(\.isEnabled) private var isEnabled

    let role: ButtonRole?
    let action: @MainActor () -> Void
    let label: AnyView

    var isDisabled: Bool?
    var triggerDismiss: Bool = true

    public var body: some View {
        SwiftUI.Button(role: role) {
            if triggerDismiss {
                alertDismiss()
            }
            action()
        } label: {
            label
        }
        .environment(\.isEnabled, !disabled)
    }

    private var disabled: Bool {
        if let isDisabled {
            isDisabled
        } else {
            !isEnabled
        }
    }

    /// Adds a condition that controls whether users can interact with this button.
    ///
    /// - Parameter disabled: A Boolean value that determines whether users can interact with this button.
    ///
    /// - Returns: A button that controls whether users can interact with this button.
    nonisolated public func disabled(_ disabled: Bool) -> Self {
        var view = self
        view.isDisabled = disabled
        return view
    }

    /// Adds a condition that controls whether this button triggers a dismiss action.
    ///
    /// - Parameter disabled: A Boolean value that determines whether this button triggers a dismiss action.
    ///
    /// - Returns: A button that controls whether a dismiss action is triggered.
    nonisolated public func dismissDisabled(_ disabled: Bool) -> Self {
        var view = self
        view.triggerDismiss = !disabled
        return view
    }
}

// MARK: - Some View

extension Button {
    /// Creates a button that displays a custom label.
    ///
    /// - Parameters:
    ///     - role: An optional semantic role that describes the button.
    ///             A value of `nil` means that the button doesn't have an assigned role.
    ///     - action: The action to perform when the user triggers the button.
    ///     - label: A view that describes the purpose of the button's `action`.
    public init<Label>(
        role: ButtonRole? = nil,
        action: @escaping @MainActor () -> Void,
        @ViewBuilder label: () -> Label
    ) where Label: View {
        self.role = role
        self.action = action
        self.label = AnyView(label())
    }
}

// MARK: - Text

extension Button {
    /// Creates a button with a specified role that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///     - titleKey: The key for the button's localized title, that describes the purpose of the button's `action`.
    ///     - role: An optional semantic role describing the button.
    ///             A value of `nil` means that the button doesn't have an assigned role.
    ///     - action: The action to perform when the user triggers the button.
    public init(
        _ titleKey: LocalizedStringKey,
        role: ButtonRole? = nil,
        action: @escaping @MainActor () -> Void
    ) {
        self.role = role
        self.action = action
        self.label = AnyView(Text(titleKey))
    }

    /// Creates a button with a specified role that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///     - titleResource: Text resource for the button's localized title, that describes the purpose of the button's `action`.
    ///     - role: An optional semantic role describing the button.
    ///             A value of `nil` means that the button doesn't have an assigned role.
    ///     - action: The action to perform when the user triggers the button.
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    public init(
        _ titleResource: LocalizedStringResource,
        role: ButtonRole? = nil,
        action: @escaping @MainActor () -> Void
    ) {
        self.role = role
        self.action = action
        self.label = AnyView(Text(titleResource))
    }

    /// Creates a button with a specified role that generates its label from a string.
    ///
    /// - Parameters:
    ///     - title: A string that describes the purpose of the button's `action`.
    ///     - role: An optional semantic role describing the button.
    ///             A value of `nil` means that the button doesn't have an assigned role.
    ///     - action: The action to perform when the user interacts with the button.
    public init<S>(
        _ title: S,
        role: ButtonRole? = nil,
        action: @escaping @MainActor () -> Void
    ) where S: StringProtocol {
        self.role = role
        self.action = action
        self.label = AnyView(Text(title))
    }
}

// MARK: - Label

extension Button {
    /// Creates a button with a specified role that generates its label from a localized string key and a system image.
    ///
    /// - Parameters:
    ///     - titleKey: The key for the button's localized title, that describes the purpose of the button's `action`.
    ///     - systemImage: The name of the image resource to lookup.
    ///     - role: An optional semantic role describing the button.
    ///             A value of `nil` means that the button doesn't have an assigned role.
    ///     - action: The action to perform when the user triggers the button.
    public init(
        _ titleKey: LocalizedStringKey,
        systemImage: String,
        role: ButtonRole? = nil,
        action: @escaping @MainActor () -> Void
    ) {
        self.role = role
        self.action = action
        let label = Label(titleKey, systemImage: systemImage)
        self.label = AnyView(label)
    }

    /// Creates a button with a specified role that generates its label from a localized string key and a system image.
    ///
    /// - Parameters:
    ///     - titleKey: Text resource for the button's localized title, that describes the purpose of the button's `action`.
    ///     - systemImage: The name of the image resource to lookup.
    ///     - role: An optional semantic role describing the button.
    ///             A value of `nil` means that the button doesn't have an assigned role.
    ///     - action: The action to perform when the user triggers the button.
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    public init(
        _ titleResource: LocalizedStringResource,
        systemImage: String,
        role: ButtonRole? = nil,
        action: @escaping @MainActor () -> Void
    ) {
        self.role = role
        self.action = action
        let label = Label {
            Text(titleResource)
        } icon: {
            Image(systemName: systemImage)
        }
        self.label = AnyView(label)
    }

    /// Creates a button with a specified role that generates its label from a localized string key and a system image.
    ///
    /// - Parameters:
    ///     - title: A string that describes the purpose of the button's `action`.
    ///     - systemImage: The name of the image resource to lookup.
    ///     - role: An optional semantic role describing the button.
    ///             A value of `nil` means that the button doesn't have an assigned role.
    ///     - action: The action to perform when the user triggers the button.
    public init<S>(
        _ title: S,
        systemImage: String,
        role: ButtonRole? = nil,
        action: @escaping @MainActor () -> Void
    ) where S: StringProtocol {
        self.role = role
        self.action = action
        let label = Label(title, systemImage: systemImage)
        self.label = AnyView(label)
    }
}

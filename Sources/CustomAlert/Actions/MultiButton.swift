//
//  MultiButton.swift
//  CustomAlert
//
//  Created by David Walter on 29.04.22.
//

import SwiftUI

/// A control that wraps multiple actions horizontally.
///
/// Used to create side by side buttons on a `.customAlert`
@MainActor public struct MultiButton: View {
    @Environment(\.customAlertConfiguration) private var configuration
    @Environment(\.isEnabled) private var isEnabled

    let actions: [CustomAlertAction]
    var isDisabled: Bool?

    /// Creates multiple buttons within the MultiButton Layout.
    ///
    /// - Parameters:
    ///   - content: The `ViewBuilder` with multiple `Button`s
    public init(@ActionBuilder content: () -> [CustomAlertAction]) {
        self.actions = content()
    }

    public var body: some View {
        HStack(spacing: configuration.button.spacing) {
            actions.first
            ForEach(Array(actions.dropFirst().enumerated()), id: \.offset) { _, action in
                if !configuration.button.hideDivider {
                    Divider()
                }
                action
            }
        }
        .environment(\.isEnabled, !disabled)
        .fixedSize(horizontal: false, vertical: true)
        .environment(\.alertButtonHeight, .infinity)
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
}

#Preview {
    List {
        CustomAlertRow {
            Text("Hello World")
                .padding()
        } actions: {
            MultiButton {
                Button(role: .cancel) {
                    print("Cancel")
                } label: {
                    Text("Cancel")
                }
                Button {
                    print("OK")
                } label: {
                    Text("OK")
                }
            }
        }
    }
}

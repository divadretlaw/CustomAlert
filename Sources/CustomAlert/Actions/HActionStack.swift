//
//  ActionHStack.swift
//  CustomAlert
//
//  Created by David Walter on 03.01.26.
//

import SwiftUI

@available(*, deprecated, renamed: "HActionStack")
public typealias MultiButton = HActionStack

/// A view that arranges its actions in a horizontal line.
@MainActor public struct HActionStack: View {
    @Environment(\.customAlertConfiguration) private var configuration
    @Environment(\.isEnabled) private var isEnabled

    let actions: [CustomAlertAction]
    var isDisabled: Bool?

    @_disfavoredOverload public init(@ActionBuilder content: () -> [CustomAlertAction]) {
        self.actions = content()
    }

    @_disfavoredOverload init(actions: [CustomAlertAction]) {
        self.actions = actions
    }

    public var body: some View {
        SwiftUI.HStack(spacing: configuration.button.spacing) {
            ForEach(Array(actions.enumerated()), id: \.offset) { index, action in
                if index != 0, !configuration.button.hideDivider {
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

    nonisolated public func disabled(_ disabled: Bool) -> Self {
        var view = self
        view.isDisabled = disabled
        return view
    }
}

#Preview {
    CustomAlert(isPresented: .constant(true)) {
        Text("Preview")
    } content: {
        Text("Hello World")
    } actions: {
        HActionStack {
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

#Preview {
    CustomAlert(isPresented: .constant(true)) {
        Text("Preview")
    } content: {
        Text("Hello World")
    } actions: {
        [
            Button {
                print("OK")
            } label: {
                Text("OK")
            },
            Button(role: .cancel) {
                print("Cancel")
            } label: {
                Text("Cancel")
            }
        ]
    }
}

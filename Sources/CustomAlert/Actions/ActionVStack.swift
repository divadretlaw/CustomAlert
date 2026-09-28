//
//  ActionVStack.swift
//  CustomAlert
//
//  Created by David Walter on 03.01.26.
//

import SwiftUI

@MainActor public struct ActionVStack: View {
    @Environment(\.customAlertConfiguration) private var configuration
    @Environment(\.isEnabled) private var isEnabled

    let actions: [CustomAlertAction]
    var isDisabled: Bool?

    public init(@ActionBuilder content: () -> [CustomAlertAction]) {
        self.actions = content()
    }

    init(actions: [CustomAlertAction]) {
        self.actions = actions
    }

    public var body: some View {
        VStack(spacing: configuration.button.spacing) {
            ForEach(Array(actions.enumerated()), id: \.offset) { index, action in
                if index != 0, !configuration.button.hideDivider {
                    Divider()
                }
                action
            }
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
        ActionVStack {
            Button {
                print("OK")
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                print("Cancel")
            } label: {
                Text("Cancel")
            }
        }
    }
}

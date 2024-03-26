//
//  Environment+AlertDismissAction.swift
//  CustomAlert
//
//  Created by David Walter on 25.03.24.
//

import SwiftUI

/// An action that dismisses a custom alert presentation.
public struct AlertDismissAction {
    let action: () -> Void
    
    func callAsFunction() {
        action()
    }
}

private struct AlertDismissActionKey: EnvironmentKey {
    static var defaultValue: AlertDismissAction {
        AlertDismissAction {
            // nothing
        }
    }
}

public extension EnvironmentValues {
    /// An action that dismisses the current alert presentation presentation.
    var alertDismiss: AlertDismissAction {
        get { self[AlertDismissActionKey.self] }
        set { self[AlertDismissActionKey.self] = newValue }
    }
}

public extension View {
    func onAlertDismiss(action: @escaping () -> Void) -> some View {
        environment(\.alertDismiss, AlertDismissAction(action: action))
    }
}

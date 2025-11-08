//
//  Environment+AlertDismissAction.swift
//  CustomAlert
//
//  Created by David Walter on 25.03.24.
//

import SwiftUI

/// An action that dismisses a custom alert presentation.
///
/// Use the `alertDismiss` environment value to get the instance
/// of this structure for a given `Environment`. Then call the instance
/// to perform the dismissal. You call the instance directly because
/// it defines a ``AlertDismissAction/callAsFunction()``
/// method that Swift calls when you call the instance.
public struct AlertDismissAction {
    let action: () -> Void

    /// Dismisses the alert if it is currently presented.
    ///
    /// Don't call this method directly. SwiftUI calls it for you when you
    /// call the ``AlertDismissAction`` structure that you get from the
    /// `Environment`:
    ///
    /// ```swift
    /// private struct SheetContents: View {
    ///     @Environment(\.alertDismiss) private var alertDismiss
    ///
    ///     var body: some View {
    ///         Button("Done") {
    ///             alertDismiss() // Implicitly calls dismiss.callAsFunction()
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)
    /// in *The Swift Programming Language*.
    public func callAsFunction() {
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
    /// Perform an action when the alert dismisses
    func onAlertDismiss(action: @escaping () -> Void) -> some View {
        environment(\.alertDismiss, AlertDismissAction(action: action))
    }
}

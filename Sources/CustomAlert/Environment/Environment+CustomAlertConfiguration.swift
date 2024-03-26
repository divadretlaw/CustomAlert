//
//  Environment+CustomAlertConfiguration.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import SwiftUI

private struct CustomAlertConfigurationKey: EnvironmentKey {
    static var defaultValue: CustomAlertConfiguration {
        CustomAlertConfiguration()
    }
}

public extension EnvironmentValues {
    var customAlertConfiguration: CustomAlertConfiguration {
        get { self[CustomAlertConfigurationKey.self] }
        set { self[CustomAlertConfigurationKey.self] = newValue }
    }
}

extension View {
    /// Create a custom alert configuration
    ///
    /// - Parameter configure: Callback to change the default configuration
    ///
    /// - Returns: The view with a customized ``CustomAlertConfiguration``
    func customAlertStyle(style configure: (inout CustomAlertConfiguration) -> Void) -> some View {
        environment(\.customAlertConfiguration, .create(configure: configure))
    }
}

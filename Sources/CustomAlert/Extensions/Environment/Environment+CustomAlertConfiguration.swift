//
//  Environment+CustomAlertConfiguration.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import SwiftUI

private struct CustomAlertConfigurationKey: EnvironmentKey {
    static var defaultValue: CustomAlertConfiguration {
        CustomAlertConfiguration.default
    }
}

public extension EnvironmentValues {
    /// The configuration values for custom alerts
    var customAlertConfiguration: CustomAlertConfiguration {
        get { self[CustomAlertConfigurationKey.self] }
        set { self[CustomAlertConfigurationKey.self] = newValue }
    }
}

public extension View {
    /// Create a custom alert configuration
    ///
    /// - Parameter configure: Callback to change the current configuration
    ///
    /// - Returns: The view with a customized ``CustomAlertConfiguration``
    func configureCustomAlert(configure: @escaping (inout CustomAlertConfiguration) -> Void) -> some View {
        modifier(CustomAlertConfigurator(configure: configure))
    }

    /// Create a custom alert configuration
    ///
    /// - Parameter configuration: The custom alert configuration
    ///
    /// - Returns: The view with a customized ``CustomAlertConfiguration``
    func configureCustomAlert(_ configuration: CustomAlertConfiguration) -> some View {
        environment(\.customAlertConfiguration, configuration)
    }
}

private struct CustomAlertConfigurator: ViewModifier {
    @Environment(\.customAlertConfiguration) private var configuration
    var configure: (inout CustomAlertConfiguration) -> Void

    func body(content: Content) -> some View {
        content
            .environment(\.customAlertConfiguration, update(configure: configure))
    }

    private func update(configure: (inout CustomAlertConfiguration) -> Void) -> CustomAlertConfiguration {
        var configuration = self.configuration
        configure(&configuration)
        return configuration
    }
}

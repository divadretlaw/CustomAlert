//
//  Environment.swift
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

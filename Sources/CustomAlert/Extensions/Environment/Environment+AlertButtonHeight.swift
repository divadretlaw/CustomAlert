//
//  Environment+AlertButtonHeight.swift
//  CustomAlert
//
//  Created by David Walter on 26.03.24.
//

import SwiftUI

private struct AlertButtonHeightKey: EnvironmentKey {
    static var defaultValue: CGFloat? {
        nil
    }
}

extension EnvironmentValues {
    var alertButtonHeight: CGFloat? {
        get { self[AlertButtonHeightKey.self] }
        set { self[AlertButtonHeightKey.self] = newValue }
    }
}

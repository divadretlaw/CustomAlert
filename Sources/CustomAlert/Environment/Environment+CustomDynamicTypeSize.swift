//
//  Environment+CustomDynamicTypeSize.swift
//  CustomAlert
//
//  Created by David Walter on 05.09.24.
//

import SwiftUI
import UIKit
import WindowKit

extension EnvironmentValues {
    /// The configuration values for custom alerts
    var customDynamicTypeSize: CustomDynamicTypeSize {
        if #available(iOS 15.0, *) {
            let dynamicTypeSize = self[keyPath: \.dynamicTypeSize]
            return CustomDynamicTypeSize(dynamicTypeSize: dynamicTypeSize)
        } else {
            guard let window = self[keyPath: \.window] else {
                return .large
            }
            let sizeCategory = window.traitCollection.preferredContentSizeCategory
            return CustomDynamicTypeSize(sizeCategory: sizeCategory)
        }
    }
}

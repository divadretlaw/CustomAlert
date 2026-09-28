//
//  CustomAlertState.swift
//  CustomAlert
//
//  Created by David Walter on 18.08.25.
//

import Foundation
import SwiftUI

public struct CustomAlertState: Sendable {
    static let `default` = CustomAlertState()

    private let dynamicTypeSize: DynamicTypeSize
    /// Checks if the alert is scrolling
    public let isScrolling: Bool

    init() {
        self.dynamicTypeSize = .large
        self.isScrolling = false
    }

    init(dynamicTypeSize: DynamicTypeSize, isScrolling: Bool) {
        self.dynamicTypeSize = dynamicTypeSize
        self.isScrolling = isScrolling
    }

    /// Checks if the alert is using an accessibility type size
    public var isAccessibilitySize: Bool {
        dynamicTypeSize.isAccessibilitySize
    }
}

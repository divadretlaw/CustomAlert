//
//  CustomAlertConfiguration.Value.swift
//  CustomAlert
//
//  Created by David Walter on 18.08.25.
//

import Foundation
import SwiftUI

extension CustomAlertConfiguration {
    /// A configuration value that gets calculated by the alert's state
    enum Value<Value>: Sendable where Value: Sendable {
        /// A static value applies to all possible states
        case `static`(Value)
        /// A dynamic values changes depending on the given state
        case dynamic(@Sendable (CustomAlertState) -> Value)

        func callAsFunction() -> Value {
            callAsFunction(.default)
        }

        func callAsFunction(_ state: CustomAlertState) -> Value {
            switch self {
            case .static(let value):
                value
            case .dynamic(let calculate):
                calculate(state)
            }
        }
    }
}

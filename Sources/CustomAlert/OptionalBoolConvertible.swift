//
//  OptionalBoolConvertible.swift
//  CustomAlert
//
//  Created by David Walter on 31.03.24.
//

import SwiftUI

enum OptionalBoolConvertible {
    case present
}

extension Binding where Value == OptionalBoolConvertible? {
    init(bool binding: Binding<Bool>) {
        self = Binding<OptionalBoolConvertible?> {
            if binding.wrappedValue {
                return .present
            } else {
                return nil
            }
        } set: { newValue in
            if newValue != nil {
                binding.wrappedValue = true
            } else {
                binding.wrappedValue = false
            }
        }
    }
}

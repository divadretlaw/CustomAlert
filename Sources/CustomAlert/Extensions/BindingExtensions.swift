//
//  BindingExtensions.swift
//  CustomAlert
//
//  Created by David Walter on 28.02.24.
//

import SwiftUI

extension Binding where Value == Bool {
    func alert() -> Binding<AlertIdentifiable?> {
        Binding<AlertIdentifiable?> {
            if wrappedValue {
                return .present
            } else {
                return nil
            }
        } set: { newValue in
            if newValue != nil {
                wrappedValue = true
            } else {
                wrappedValue = false
            }
        }
    }
}

//
//  AlertIdentifiable.swift
//  CustomAlert
//
//  Created by David Walter on 31.03.24.
//

import SwiftUI

enum AlertIdentifiable: Int, Identifiable, Hashable, Equatable {
    case present
    
    var id: Int { rawValue }
}

extension Binding where Value == AlertIdentifiable? {
    init(bool binding: Binding<Bool>) {
        self = Binding<AlertIdentifiable?> {
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

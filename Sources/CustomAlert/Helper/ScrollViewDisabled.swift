//
//  ScrollViewDisabled.swift
//  CustomAlert
//
//  Created by David Walter on 31.03.24.
//

import SwiftUI

extension View {
    func scrollViewDisabled(_ disabled: Bool) -> some View {
        modifier(DisabledViewModifier(isDisabled: disabled))
    }
}

private struct DisabledViewModifier: ViewModifier {
    var isDisabled: Bool
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollDisabled(isDisabled)
        } else {
            content.disabled(isDisabled)
        }
    }
}

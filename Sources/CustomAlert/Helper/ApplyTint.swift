//
//  ApplyTint.swift
//  CustomAlert
//
//  Created by David Walter on 31.03.24.
//

import SwiftUI

extension View {
    func applyTint(_ uiColor: UIColor?) -> some View {
        modifier(TintApplier(uiColor: uiColor))
    }
    func applyTint(_ color: Color?) -> some View {
        modifier(TintApplier(color: color))
    }
}

private struct TintApplier: ViewModifier {
    var color: Color?
    
    init(color: Color?) {
        self.color = color
    }
    
    init(uiColor: UIColor?) {
        if let uiColor = uiColor {
            if #available(iOS 15.0, *) {
                self.color = Color(uiColor: uiColor)
            } else {
                self.color = Color(uiColor)
            }
        } else {
            self.color = nil
        }
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.tint(color)
        } else if #available(iOS 15.0, *) {
            content.tint(color)
        } else {
            content.foregroundColor(color)
        }
    }
}

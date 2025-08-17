//
//  ColorExtensions.swift
//  CustomAlert
//
//  Created by David Walter on 31.03.24.
//

import SwiftUI

extension Color {
    static var almostClear: Color {
        Color.black.opacity(0.0001)
    }

    static var liquidGlassBackgroundColor: Color {
        Color(uiColor: .liquidGlassBackgroundColor)
    }

    static var classicBackgroundColor: Color {
        Color(uiColor: .classicBackgroundColor)
    }
}

private extension UIColor {
    static var customAlertColor: UIColor {
        let traitCollection = UITraitCollection(activeAppearance: .active)
        return .tintColor.resolvedColor(with: traitCollection)
    }

    static var liquidGlassBackgroundColor: UIColor {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                UIColor.black.withAlphaComponent(0.3)
            default:
                UIColor.white.withAlphaComponent(0.3)
            }
        }
    }

    static var classicBackgroundColor: UIColor {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                UIColor.white.withAlphaComponent(0.135)
            default:
                UIColor.black.withAlphaComponent(0.085)
            }
        }
    }
}

#Preview("Liquid Glass") {
    ZStack {
        Color(.displayP3, red: 0.23, green: 0.53, blue: 0.97, opacity: 1)
        // 27 56 97
        VStack(spacing: 0) {
            Color.clear
            Color.liquidGlassBackgroundColor
        }
    }
}

#Preview("Classic Glass") {
    ZStack {
        Color.blue
        VStack(spacing: 0) {
            Color.classicBackgroundColor
            Color.clear
        }
    }
}

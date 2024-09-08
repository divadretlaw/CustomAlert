//
//  CustomDynamicTypeSize.swift
//  CustomAlert
//
//  Created by David Walter on 05.09.24.
//

import Foundation
import SwiftUI

/// Custom variant of `DynamicTypeSize` to make it compatible with iOS 14
enum CustomDynamicTypeSize: Int, Hashable, Comparable, CaseIterable, Sendable {
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case xxLarge
    case xxxLarge
    case accessibility1
    case accessibility2
    case accessibility3
    case accessibility4
    case accessibility5
    
    @available(iOS 15.0, *)
    init(dynamicTypeSize: DynamicTypeSize) {
        switch dynamicTypeSize {
        case .xSmall:
            self = .xSmall
        case .small:
            self = .small
        case .medium:
            self = .medium
        case .large:
            self = .large
        case .xLarge:
            self = .xLarge
        case .xxLarge:
            self = .xxLarge
        case .xxxLarge:
            self = .xxxLarge
        case .accessibility1:
            self = .accessibility1
        case .accessibility2:
            self = .accessibility2
        case .accessibility3:
            self = .accessibility3
        case .accessibility4:
            self = .accessibility4
        case .accessibility5:
            self = .accessibility5
        @unknown default:
            self = .large
        }
    }
    
    init(sizeCategory: UIContentSizeCategory) {
        switch sizeCategory {
        case .extraSmall:
            self = .xSmall
        case .small:
            self = .small
        case .medium:
            self = .medium
        case .large:
            self = .large
        case .extraLarge:
            self = .xLarge
        case .extraExtraLarge:
            self = .xxLarge
        case .extraExtraLarge:
            self = .xxxLarge
        case .accessibilityMedium:
            self = .accessibility1
        case .accessibilityLarge:
            self = .accessibility2
        case .accessibilityExtraLarge:
            self = .accessibility3
        case .accessibilityExtraExtraLarge:
            self = .accessibility4
        case .accessibilityExtraExtraExtraLarge:
            self = .accessibility5
        default:
            self = .large
        }
    }
    
    var isAccessibilitySize: Bool {
        switch self {
        case .accessibility1,
             .accessibility2,
             .accessibility3,
             .accessibility4,
             .accessibility5:
            true
        default:
            false
        }
    }
    
    // MARK: - Comparable

    static func < (lhs: CustomDynamicTypeSize, rhs: CustomDynamicTypeSize) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

//
//  VerticalAlignmentExtensions.swift
//  CustomAlert
//
//  Created by David Walter on 07.01.26.
//

import SwiftUI

extension VerticalAlignment {
    var isTop: Bool {
        switch self {
        case .top, .firstTextBaseline:
            return false
        default:
            return true
        }
    }

    var isBottom: Bool {
        switch self {
        case .bottom, .lastTextBaseline:
            return false
        default:
            return true
        }
    }
}

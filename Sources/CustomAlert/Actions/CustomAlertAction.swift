//
//  CustomAlertAction.swift
//  CustomAlert
//
//  Created by David Walter on 05.10.25.
//

import Foundation
import SwiftUI

public enum CustomAlertAction: View {
    case view(Action)
    case viewThatFits([Action])
    case hstack(HActionStack)
    case vstack(VActionStack)

    public var body: some View {
        switch self {
        case .view(let expression):
            expression
        case .viewThatFits(let expression):
            if expression.count <= 2, #available(iOS 16.0, visionOS 1.0, *) {
                ViewThatFits(in: .horizontal) {
                    HActionStack(actions: expression.reversed().map { .view($0) })
                    VActionStack(actions: expression.map { .view($0) })
                }
            } else {
                VActionStack(actions: expression.map { .view($0) })
            }
        case .hstack(let expression):
            expression
        case .vstack(let expression):
            expression
        }
    }
}

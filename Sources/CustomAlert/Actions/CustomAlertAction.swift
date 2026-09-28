//
//  CustomAlertAction.swift
//  CustomAlert
//
//  Created by David Walter on 05.10.25.
//

import Foundation
import SwiftUI

public enum CustomAlertAction: View {
    case view(Button)
    case viewThatFits([Button])
    case hstack(ActionHStack)
    case vstack(ActionVStack)

    public var body: some View {
        switch self {
        case .view(let expression):
            expression
        case .viewThatFits(let expression):
            if expression.count <= 2, #available(iOS 16.0, visionOS 1.0, *) {
                ViewThatFits(in: .horizontal) {
                    ActionHStack(actions: expression.reversed().map { .view($0) })
                    ActionVStack(actions: expression.map { .view($0) })
                }
            } else {
                ActionVStack(actions: expression.map { .view($0) })
            }
        case .hstack(let expression):
            expression
        case .vstack(let expression):
            expression
        }
    }
}

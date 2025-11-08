//
//  ActionBuilder.swift
//  CustomAlert
//
//  Created by David Walter on 05.10.25.
//

import Foundation
import SwiftUI

// swiftlint:disable missing_docs
/// A custom parameter attribute that constructs custom alert actions from closures.
@MainActor
@resultBuilder
public enum ActionBuilder {
    public static func buildExpression(_ expression: Button) -> [CustomAlertAction] {
        [.button(expression)]
    }

    public static func buildExpression(_ expression: MultiButton) -> [CustomAlertAction] {
        [.multiButton(expression)]
    }

    // MARK: buildBlock

    public static func buildBlock(_ components: [CustomAlertAction]...) -> [CustomAlertAction] {
        components.flatMap { $0 }
    }

    public static func buildBlock() -> [CustomAlertAction] {
        []
    }

    // MARK: buildArray

    public static func buildArray(_ components: [[CustomAlertAction]]) -> [CustomAlertAction] {
        components.flatMap { $0 }
    }

    // MARK: buildExpression

    public static func buildExpression(_ expression: [CustomAlertAction]) -> [CustomAlertAction] {
        expression
    }

    public static func buildExpression(_ expression: [CustomAlertAction]...) -> [CustomAlertAction] {
        expression.flatMap { $0 }
    }

    // MARK: buildOptional

    public static func buildOptional(_ component: [CustomAlertAction]?) -> [CustomAlertAction] {
        component ?? []
    }

    // MARK: buildEither

    public static func buildEither(first components: [CustomAlertAction]) -> [CustomAlertAction] {
        components
    }

    public static func buildEither(second components: [CustomAlertAction]) -> [CustomAlertAction] {
        components
    }

    // MARK: buildLimitedAvailability

    static func buildLimitedAvailability(_ components: [CustomAlertAction]) -> [CustomAlertAction] {
        components
    }
}
// swiftlint:enable missing_docs

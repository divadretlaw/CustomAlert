//
//  CustomAlertAction.swift
//  CustomAlert
//
//  Created by David Walter on 05.10.25.
//

import Foundation
import SwiftUI

public enum CustomAlertAction: View {
    case button(Button)
    case multiButton(MultiButton)

    public var body: some View {
        switch self {
        case .button(let expression):
            expression
        case .multiButton(let expression):
            expression
        }
    }
}

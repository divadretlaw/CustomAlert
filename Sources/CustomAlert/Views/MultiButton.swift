//
//  MultiButton.swift
//  CustomAlert
//
//  Created by David Walter on 29.04.22.
//

import SwiftUI

/// A control that wraps multiple actions horizontally.
///
/// Used to create side by side buttons on a `.customAlert`
public struct MultiButton<Content>: View where Content: View {
    let content: Content
    
    public var body: some View {
        _VariadicView.Tree(ContentLayout()) {
            content
        }
    }
    
    /// Creates multiple buttons within the MultiButton Layout.
    ///
    /// - Parameters:
    ///   - content: The `ViewBuilder` with multiple `Button`s
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    struct ContentLayout: _VariadicView_ViewRoot {
        @Environment(\.customAlertConfiguration) private var configuration
        
        func body(children: _VariadicView.Children) -> some View {
            HStack(spacing: 0) {
                children.first
                ForEach(children.dropFirst()) { child in
                    if !configuration.button.hideDivider {
                        Divider()
                    }
                    child
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .buttonStyle(.alert)
            .environment(\.alertButtonHeight, .infinity)
        }
    }
}

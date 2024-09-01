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
    @Environment(\.customAlertConfiguration) private var configuration
    
    let content: Content
    
    /// Creates multiple buttons within the MultiButton Layout.
    ///
    /// - Parameters:
    ///   - content: The `ViewBuilder` with multiple `Button`s
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        #if swift(>=6.0)
        if #available(iOS 18.0, *) {
            HStack(spacing: 0) {
                Group(subviews: content) { subviews in
                    subviews.first
                    ForEach(subviews.dropFirst()) { child in
                        if !configuration.button.hideDivider {
                            Divider()
                        }
                        child
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .buttonStyle(.alert)
            .environment(\.alertButtonHeight, .infinity)
        } else {
            _VariadicView.Tree(ContentLayout()) {
                content
            }
        }
        #else
        _VariadicView.Tree(ContentLayout()) {
            content
        }
        #endif
    }
    
    @available(iOS, introduced: 14.0, deprecated: 18.0, message: "Use `ForEach(subviewOf:content:)` instead")
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

@available(iOS 15.0, *)
#Preview {
    List {
        CustomAlertRow {
            Text("Hello World")
                .padding()
        } actions: {
            MultiButton {
                Button(role: .cancel) {
                    print("Cancel")
                } label: {
                    Text("Cancel")
                }
                Button {
                    print("OK")
                } label: {
                    Text("OK")
                }
            }
        }
    }
}

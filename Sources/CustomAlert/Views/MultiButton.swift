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
    @MainActor struct ContentLayout: _VariadicView_ViewRoot {
        @Environment(\.customAlertConfiguration) private var configuration
        
        #if swift(>=6.0)
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
        #else
        nonisolated func body(children: _VariadicView.Children) -> some View {
            HStack(spacing: 0) {
                children.first
                ForEach(children.dropFirst()) { child in
                    if !hideDivider {
                        Divider()
                    }
                    child
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .buttonStyle(buttonStyle)
            .environment(\.alertButtonHeight, .infinity)
        }
        
        nonisolated var buttonStyle: some ButtonStyle {
            MainActor.runSync {
                AlertButtonStyle(triggerDismiss: true)
            }
        }
        
        nonisolated var hideDivider: Bool {
            MainActor.runSync {
                configuration.button.hideDivider
            }
        }
        #endif
    }
}

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

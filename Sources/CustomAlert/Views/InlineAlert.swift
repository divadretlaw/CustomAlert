//
//  InlineAlert.swift
//  CustomAlert
//
//  Created by David Walter on 30.04.22.
//

import SwiftUI

/// Display a view styled like an alert inline
public struct InlineAlert<Content, Actions>: View where Content: View, Actions: View {
    @ViewBuilder var content: () -> Content
    @ViewBuilder var actions: () -> Actions
    
    private var cornerRadius: CGFloat = 13.3333
    
    public var body: some View {
        VStack(spacing: 0) {
            content()
            
            _VariadicView.Tree(ContentLayout(), content: actions)
                .buttonStyle(.alert)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .listRowInsets(EdgeInsets())
        .cornerRadius(cornerRadius)
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.content = content
        self.actions = actions
    }
    
    /// Change the corner radius of the alert view
    ///
    /// - Parameter value: The radius to use
    public func cornerRadius(_ value: CGFloat) -> Self {
        var view = self
        view.cornerRadius = value
        return view
    }
    
    struct ContentLayout: _VariadicView_ViewRoot {
        func body(children: _VariadicView.Children) -> some View {
            VStack(spacing: 0) {
                ForEach(children) { child in
                    Divider()
                    child
                }
            }
        }
    }
}

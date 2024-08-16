//
//  InlineAlert.swift
//  CustomAlert
//
//  Created by David Walter on 30.04.22.
//

import SwiftUI

/// Display a view styled like an alert inline
public struct InlineAlert<Content, Actions>: View where Content: View, Actions: View {
    let content: Content
    let actions: Actions
    
    private var cornerRadius: CGFloat = 13.3333
    
    public var body: some View {
        VStack(spacing: 0) {
            content
            
            #if swift(>=6.0)
            if #available(iOS 18.0, *) {
                ForEach(subviews: actions) { child in
                    Divider()
                    child
                }
            } else {
                _VariadicView.Tree(ContentLayout()) {
                    actions
                }
            }
            #else
            _VariadicView.Tree(ContentLayout()) {
                actions
            }
            #endif
        }
        .buttonStyle(.alert)
        .background(Color(.secondarySystemGroupedBackground))
        .listRowInsets(.zero)
        .cornerRadius(cornerRadius)
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.content = content()
        self.actions = actions()
    }
    
    /// Change the corner radius of the alert view
    ///
    /// - Parameter value: The radius to use
    public func cornerRadius(_ value: CGFloat) -> Self {
        var view = self
        view.cornerRadius = value
        return view
    }
    
    @available(iOS, introduced: 14.0, deprecated: 18.0, message: "Use `ForEach(subviewOf:content:)` instead")
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

@available(iOS 15.0, *)
#Preview {
    List {
        InlineAlert {
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

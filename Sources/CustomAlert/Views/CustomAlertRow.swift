//
//  CustomAlertRow.swift
//  CustomAlert
//
//  Created by David Walter on 30.04.22.
//

import SwiftUI

/// Display a custom alert inlined into a `List`
public struct CustomAlertRow<Content, Actions>: View where Content: View, Actions: View {
    @Binding var isPresented: Bool
    
    let content: Content
    let actions: Actions
    
    public var body: some View {
        if isPresented {
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
            .buttonStyle(.alert(triggerDismiss: false))
            .listRowInsets(.zero)
        }
    }
    
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
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
struct CustomAlertRow_Preview: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State private var isPresented = false
        
        var body: some View {
            List {
                Section {
                    Button {
                        isPresented = true
                    } label: {
                        Text("Show Custom Alert Row")
                    }
                    
                    CustomAlertRow(isPresented: $isPresented) {
                        Text("Hello World")
                            .padding()
                    } actions: {
                        MultiButton {
                            Button(role: .cancel) {
                                isPresented = false
                                print("Cancel")
                            } label: {
                                Text("Cancel")
                            }
                            Button {
                                isPresented = false
                                print("OK")
                            } label: {
                                Text("OK")
                            }
                        }
                    }
                }
            }
            .animation(.default, value: isPresented)
        }
    }
}

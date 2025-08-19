//
//  CustomAlertRow.swift
//  CustomAlert
//
//  Created by David Walter on 30.04.22.
//

import SwiftUI

/// Display a custom alert inlined into a `List`
public struct CustomAlertRow<Content, Actions>: View where Content: View, Actions: View {
    @Environment(\.customAlertConfiguration) private var configuration
    @Binding var isPresented: Bool
    
    let content: Content
    let actions: Actions
    
    public var body: some View {
        if isPresented {
            VStack(spacing: 0) {
                content

                switch configuration.alert.dividerVisibility {
                case .hidden, .automatic:
                    EmptyView()
                case .visible:
                    Divider()
                }
                _VariadicView.Tree(ContentLayout()) {
                    actions
                }
                .padding(configuration.alert.actionPadding)
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

    @MainActor struct ContentLayout: _VariadicView_ViewRoot {
        @Environment(\.customAlertConfiguration) private var configuration

        func body(children: _VariadicView.Children) -> some View {
            VStack(spacing: configuration.button.spacing) {
                ForEach(Array(children.enumerated()), id: \.offset) { index, child in
                    if index != 0, !configuration.button.hideDivider {
                        Divider()
                    }
                    child
                }
            }
        }
    }
}

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
                }
                Section {
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

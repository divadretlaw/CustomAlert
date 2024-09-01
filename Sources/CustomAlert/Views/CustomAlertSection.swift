//
//  CustomAlertSection.swift
//  CustomAlert
//
//  Created by David Walter on 30.04.22.
//

import SwiftUI

/// Display a custom alert inlined into a `List`
public struct CustomAlertSection<Content, Actions, Header, Footer>: View where Content: View, Actions: View, Header: View, Footer: View {
    @Binding var isPresented: Bool
    
    let content: Content
    let actions: Actions
    let header: Header
    let footer: Footer
    
    public var body: some View {
        if isPresented {
            Section {
                CustomAlertRow {
                    content
                } actions: {
                    actions
                }
            } header: {
                header
            } footer: {
                footer
            }
        }
    }
    
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
        self.header = header()
        self.footer = footer()
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
        self.header = header()
        self.footer = footer()
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

extension CustomAlertSection where Header == EmptyView, Footer == EmptyView {
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
        self.header = EmptyView()
        self.footer = EmptyView()
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
        self.header = EmptyView()
        self.footer = EmptyView()
    }
}

extension CustomAlertSection where Footer == EmptyView {
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder header: @escaping () -> Header
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
        self.header = header()
        self.footer = EmptyView()
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder header: @escaping () -> Header
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
        self.header = header()
        self.footer = EmptyView()
    }
}

extension CustomAlertSection where Header == EmptyView {
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
        self.header = EmptyView()
        self.footer = footer()
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
        self.header = EmptyView()
        self.footer = footer()
    }
}

@available(iOS 15.0, *)
struct CustomAlertSection_Preview: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State private var isPresented = false
        
        var body: some View {
            List {
                CustomAlertSection(isPresented: $isPresented) {
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
                .transition(.move(edge: .leading))
                
                Section {
                    Button {
                        isPresented = true
                    } label: {
                        Text("Show Custom Alert Section")
                    }
                }
            }
            .animation(.default, value: isPresented)
        }
    }
}

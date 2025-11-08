//
//  CustomAlertSection.swift
//  CustomAlert
//
//  Created by David Walter on 30.04.22.
//

import SwiftUI

/// Display a custom alert inlined into a `List`
public struct CustomAlertSection<Content, Header, Footer>: View where Content: View, Header: View, Footer: View {
    @Binding var isPresented: Bool

    let content: Content
    let actions: [CustomAlertAction]
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

    /// Create a custom alert section
    ///
    /// - Parameters:
    ///     - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///     - content: A `ViewBuilder` returing the alerts main view.
    ///     - actions: A `ActionBuilder` returning the alert's actions.
    ///     - header: A view to use as the section's header.
    ///     - footer: A view to use as the section's footer.
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction],
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
        self.header = header()
        self.footer = footer()
    }

    /// Create a custom alert section
    ///
    /// - Parameters:
    ///     - content: A `ViewBuilder` returing the alerts main view.
    ///     - actions: A `ActionBuilder` returning the alert's actions.
    ///     - header: A view to use as the section's header.
    ///     - footer: A view to use as the section's footer.
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction],
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
        self.header = header()
        self.footer = footer()
    }
}

extension CustomAlertSection where Header == EmptyView, Footer == EmptyView {
    /// Create a custom alert section
    ///
    /// - Parameters:
    ///     - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///     - content: A `ViewBuilder` returing the alerts main view.
    ///     - actions: A `ActionBuilder` returning the alert's actions.
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction]
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
        self.header = EmptyView()
        self.footer = EmptyView()
    }

    /// Create a custom alert section
    ///
    /// - Parameters:
    ///     - content: A `ViewBuilder` returing the alerts main view.
    ///     - actions: A `ActionBuilder` returning the alert's actions.
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction]
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
        self.header = EmptyView()
        self.footer = EmptyView()
    }
}

extension CustomAlertSection where Footer == EmptyView {
    /// Create a custom alert section
    ///
    /// - Parameters:
    ///     - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///     - content: A `ViewBuilder` returing the alerts main view.
    ///     - actions: A `ActionBuilder` returning the alert's actions.
    ///     - header: A view to use as the section's header.
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction],
        @ViewBuilder header: @escaping () -> Header
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
        self.header = header()
        self.footer = EmptyView()
    }

    /// Create a custom alert section
    ///
    /// - Parameters:
    ///     - content: A `ViewBuilder` returing the alerts main view.
    ///     - actions: A `ActionBuilder` returning the alert's actions.
    ///     - header: A view to use as the section's header.
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction],
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
    /// Create a custom alert section
    ///
    /// - Parameters:
    ///     - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///     - content: A `ViewBuilder` returing the alerts main view.
    ///     - actions: A `ActionBuilder` returning the alert's actions.
    ///     - footer: A view to use as the section's footer.
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction],
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
        self.header = EmptyView()
        self.footer = footer()
    }

    /// Create a custom alert section
    ///
    /// - Parameters:
    ///     - content: A `ViewBuilder` returing the alerts main view.
    ///     - actions: A `ActionBuilder` returning the alert's actions.
    ///     - footer: A view to use as the section's footer.
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction],
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
        self.header = EmptyView()
        self.footer = footer()
    }
}

@available(iOS 17.0, visionOS 1.0, *)
#Preview {
    @Previewable @State var isPresented = false
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
            SwiftUI.Button {
                isPresented = true
            } label: {
                Text("Show Custom Alert Section")
            }
        }
    }
    .animation(.default, value: isPresented)
}

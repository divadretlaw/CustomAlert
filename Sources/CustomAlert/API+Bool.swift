//
//  API+Bool.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI
import Combine
import WindowKit

public extension View {
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The optional title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Content, Actions>(
        _ title: @autoclosure @escaping () -> Text? = nil,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View where Content: View, Actions: View {
        modifier(
            CustomAlertHandler(
                isPresented: isPresented,
                windowScene: nil,
                alertTitle: title,
                alertContent: content,
                alertActions: actions
            )
        )
    }
    
    /// Presents an alert when a given condition is true, using
    /// a localized string key for a title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Content, Actions>(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View where Content: View, Actions: View {
        self.customAlert(Text(title), isPresented: isPresented, content: content, actions: actions)
    }
    
    /// Presents an alert when a given condition is true
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    @_disfavoredOverload
    func customAlert<Title, Content, Actions>(
        _ title: Title,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View where Title: StringProtocol, Content: View, Actions: View {
        self.customAlert(Text(title), isPresented: isPresented, content: content, actions: actions)
    }
    
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - title: Callback for the optional title of the alert.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Content, Actions>(
        isPresented: Binding<Bool>,
        title: @escaping () -> Text?,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View where Content: View, Actions: View {
        modifier(
            CustomAlertHandler(
                isPresented: isPresented,
                windowScene: nil,
                alertTitle: title,
                alertContent: content,
                alertActions: actions
            )
        )
    }
}

public extension View {
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The optional title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - windowScene: The window scene to present the alert on.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Content, Actions>(
        _ title: @autoclosure @escaping () -> Text? = nil,
        isPresented: Binding<Bool>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View where Content: View, Actions: View {
        modifier(
            CustomAlertHandler(
                isPresented: isPresented,
                windowScene: windowScene,
                alertTitle: title,
                alertContent: content,
                alertActions: actions
            )
        )
    }
    
    /// Presents an alert when a given condition is true, using
    /// a localized string key for a title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - windowScene: The window scene to present the alert on.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access func customAlert<Content, Actions>(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View where Content: View, Actions: View {
        self.customAlert(Text(title), isPresented: isPresented, on: windowScene, content: content, actions: actions)
    }
    
    /// Presents an alert when a given condition is true
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - windowScene: The window scene to present the alert on.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    @_disfavoredOverload
    func customAlert<Title, Content, Actions>(
        _ title: Title,
        isPresented: Binding<Bool>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View where Title: StringProtocol, Content: View, Actions: View {
        self.customAlert(Text(title), isPresented: isPresented, on: windowScene, content: content, actions: actions)
    }
    
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - windowScene: The window scene to present the alert on.
    ///   - title: Callback for the optional title of the alert.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Content, Actions>(
        isPresented: Binding<Bool>,
        on windowScene: UIWindowScene,
        title: @escaping () -> Text?,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View where Content: View, Actions: View {
        self.customAlert(title(), isPresented: isPresented, on: windowScene, content: content, actions: actions)
    }
}

public extension View {
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The optional title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @warn_unqualified_access
    func customAlert<Content>(
        _ title: Text? = nil,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        self.customAlert(title, isPresented: isPresented, content: content, actions: { /* no actions */ })
    }
    
    /// Presents an alert when a given condition is true, using
    /// a localized string key for a title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @warn_unqualified_access
    func customAlert<Content>(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        self.customAlert(Text(title), isPresented: isPresented, content: content, actions: { /* no actions */ })
    }
    
    /// Presents an alert when a given condition is true
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @warn_unqualified_access
    @_disfavoredOverload
    func customAlert<Title, Content>(
        _ title: Title,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Title: StringProtocol, Content: View {
        self.customAlert(Text(title), isPresented: isPresented, content: content, actions: { /* no actions */ })
    }
    
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - title: Callback for the optional title of the alert.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @warn_unqualified_access
    func customAlert<Content>(
        isPresented: Binding<Bool>,
        title: @escaping () -> Text?,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        self.customAlert(title(), isPresented: isPresented, content: content, actions: { /* no actions */ })
    }
}

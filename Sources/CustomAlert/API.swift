//
//  ViewExtensions.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI
import Combine
import WindowSceneReader

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
    @warn_unqualified_access func customAlert<Content, Actions>(_ title: Text? = nil,
                                                                isPresented: Binding<Bool>,
                                                                @ViewBuilder content: @escaping () -> Content,
                                                                @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Content: View, Actions: View {
        self.background(WindowSceneReader { windowScene in
            Color.clear
                .customAlert(title, isPresented: isPresented, on: windowScene, content: content, actions: actions)
        })
        .disabled(isPresented.wrappedValue)
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
    @warn_unqualified_access func customAlert<Content, Actions>(_ title: LocalizedStringKey,
                                                                isPresented: Binding<Bool>,
                                                                @ViewBuilder content: @escaping () -> Content,
                                                                @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Content: View, Actions: View {
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
    @warn_unqualified_access func customAlert<Title, Content, Actions>(_ title: Title,
                                                                       isPresented: Binding<Bool>,
                                                                       @ViewBuilder content: @escaping () -> Content,
                                                                       @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Title: StringProtocol, Content: View, Actions: View {
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
    @warn_unqualified_access func customAlert<Content, Actions>(isPresented: Binding<Bool>,
                                                                title: @escaping () -> Text?,
                                                                @ViewBuilder content: @escaping () -> Content,
                                                                @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Content: View, Actions: View {
        self.customAlert(title(), isPresented: isPresented, content: content, actions: actions)
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
    @ViewBuilder @warn_unqualified_access func customAlert<Content, Actions>(_ title: Text? = nil,
                                                                             isPresented: Binding<Bool>,
                                                                             on windowScene: UIWindowScene,
                                                                             @ViewBuilder content: @escaping () -> Content,
                                                                             @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Content: View, Actions: View {
        if #available(iOS 14, *) {
            self.onChange(of: isPresented.wrappedValue) { value in
                if value {
                    AlertWindow.present(on: windowScene) {
                        CustomAlert(title: title, isPresented: isPresented, content: content, actions: actions)
                    }
                } else {
                    AlertWindow.dismiss(on: windowScene)
                }
            }
            .onAppear {
                guard isPresented.wrappedValue else { return }
                AlertWindow.present(on: windowScene) {
                    CustomAlert(title: title, isPresented: isPresented, content: content, actions: actions)
                }
            }
            .onDisappear {
                AlertWindow.dismiss(on: windowScene)
            }
        } else {
            self.onReceive(Just(isPresented.wrappedValue)) { value in
                if value {
                    AlertWindow.present(on: windowScene) {
                        CustomAlert(title: title, isPresented: isPresented, content: content, actions: actions)
                    }
                } else {
                    // Cannot use this to hide the alert on iOS 13 because `onReceive`
                    // will get called for all alerts if there are multiple on a single view
                    // causing all alerts to be hidden immediately after appearing
                }
            }
            .onDisappear {
                AlertWindow.dismiss(on: windowScene)
            }
        }
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
    @warn_unqualified_access func customAlert<Content, Actions>(_ title: LocalizedStringKey,
                                                                isPresented: Binding<Bool>,
                                                                on windowScene: UIWindowScene,
                                                                @ViewBuilder content: @escaping () -> Content,
                                                                @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Content: View, Actions: View {
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
    @warn_unqualified_access func customAlert<Title, Content, Actions>(_ title: Title,
                                                                       isPresented: Binding<Bool>,
                                                                       on windowScene: UIWindowScene,
                                                                       @ViewBuilder content: @escaping () -> Content,
                                                                       @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Title: StringProtocol, Content: View, Actions: View {
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
    @warn_unqualified_access func customAlert<Content, Actions>(isPresented: Binding<Bool>,
                                                                on windowScene: UIWindowScene,
                                                                title: @escaping () -> Text?,
                                                                @ViewBuilder content: @escaping () -> Content,
                                                                @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Content: View, Actions: View {
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
    @warn_unqualified_access func customAlert<Content>(_ title: Text? = nil,
                                                       isPresented: Binding<Bool>,
                                                       @ViewBuilder content: @escaping () -> Content) -> some View
    where Content: View {
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
    @warn_unqualified_access func customAlert<Content>(_ title: LocalizedStringKey,
                                                       isPresented: Binding<Bool>,
                                                       @ViewBuilder content: @escaping () -> Content) -> some View
    where Content: View {
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
    @warn_unqualified_access func customAlert<Title, Content>(_ title: Title,
                                                              isPresented: Binding<Bool>,
                                                              @ViewBuilder content: @escaping () -> Content) -> some View
    where Title: StringProtocol, Content: View {
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
    @warn_unqualified_access func customAlert<Content>(isPresented: Binding<Bool>,
                                                       title: @escaping () -> Text?,
                                                       @ViewBuilder content: @escaping () -> Content) -> some View
    where Content: View {
        self.customAlert(title(), isPresented: isPresented, content: content, actions: { /* no actions */ })
    }
}

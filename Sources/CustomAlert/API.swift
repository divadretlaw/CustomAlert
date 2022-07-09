//
//  ViewExtensions.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI
import Combine

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
    ///   - content: A ``ViewBuilder`` returing the alerts main view.
    ///   - actions: A ``ViewBuilder`` returning the alert's actions.
    @ViewBuilder func customAlert<Content, Actions>(_ title: Text? = nil,
                                                    isPresented: Binding<Bool>,
                                                    @ViewBuilder content: @escaping () -> Content,
                                                    @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Content: View, Actions: View {
        if #available(iOS 14, *) {
            onChange(of: isPresented.wrappedValue) { value in
                if value {
                    AlertWindow.present(CustomAlert(title: title, isPresented: isPresented, content: content, actions: actions))
                } else {
                    AlertWindow.dismiss()
                }
            }
            .disabled(isPresented.wrappedValue)
            .onAppear {
                guard isPresented.wrappedValue else { return }
                AlertWindow.present(CustomAlert(title: title, isPresented: isPresented, content: content, actions: actions))
            }
            .onDisappear {
                AlertWindow.dismiss()
            }
        } else {
            onReceive(Just(isPresented.wrappedValue)) { value in
                if value {
                    AlertWindow.present(CustomAlert(title: title, isPresented: isPresented, content: content, actions: actions))
                } else {
                    // Cannot use this to hide the alert on iOS 13 because `onReceive`
                    // will get called for all alerts if there are multiple on a single view
                    // causing all alerts to be hidden immediately after appearing
                }
            }
            .disabled(isPresented.wrappedValue)
            .onDisappear {
                AlertWindow.dismiss()
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
    ///   - content: A ``ViewBuilder`` returing the alerts main view.
    ///   - actions: A ``ViewBuilder`` returning the alert's actions.
    @ViewBuilder func customAlert<Content, Actions>(_ title: LocalizedStringKey,
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
    ///   - content: A ``ViewBuilder`` returing the alerts main view.
    ///   - actions: A ``ViewBuilder`` returning the alert's actions.
    @ViewBuilder func customAlert<Title, Content, Actions>(_ title: Title,
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
    ///   - content: A ``ViewBuilder`` returing the alerts main view.
    ///   - actions: A ``ViewBuilder`` returning the alert's actions.
    @ViewBuilder func customAlert<Content, Actions>(isPresented: Binding<Bool>,
                                                    title: @escaping () -> Text?,
                                                    @ViewBuilder content: @escaping () -> Content,
                                                    @ViewBuilder actions: @escaping () -> Actions) -> some View
    where Content: View, Actions: View {
        if #available(iOS 14, *) {
            onChange(of: isPresented.wrappedValue) { value in
                if value {
                    AlertWindow.present(CustomAlert(title: title(), isPresented: isPresented, content: content, actions: actions))
                } else {
                    AlertWindow.dismiss()
                }
            }
            .disabled(isPresented.wrappedValue)
            .onAppear {
                guard isPresented.wrappedValue else { return }
                AlertWindow.present(CustomAlert(title: title(), isPresented: isPresented, content: content, actions: actions))
            }
            .onDisappear {
                AlertWindow.dismiss()
            }
        } else {
            onReceive(Just(isPresented.wrappedValue)) { value in
                if value {
                    AlertWindow.present(CustomAlert(title: title(), isPresented: isPresented, content: content, actions: actions))
                } else {
                    // Cannot use this to hide the alert on iOS 13 because `onReceive`
                    // will get called for all alerts if there are multiple on a single view
                    // causing all alerts to be hidden immediately after appearing
                }
            }
            .disabled(isPresented.wrappedValue)
            .onDisappear {
                AlertWindow.dismiss()
            }
        }
    }
}

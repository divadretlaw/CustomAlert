//
//  API+Item.swift
//  CustomAlert
//
//  Created by David Walter on 28.02.24.
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
    ///   - title: A `ViewBuilder` returing the alerts title.
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Item, Content, Actions>(
        @ViewBuilder _ title: @escaping (Item) -> Text? = { _ in nil },
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder actions: @escaping (Item) -> Actions
    ) -> some View where Content: View, Actions: View {
        modifier(
            CustomAlertHandler(
                item: item,
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
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Item, Content, Actions>(
        _ title: @escaping (Item) -> LocalizedStringKey,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder actions: @escaping (Item) -> Actions
    ) -> some View where Content: View, Actions: View {
        self.customAlert({ item in Text(title(item)) }, item: item, content: content, actions: actions)
    }
    
    /// Presents an alert when a given condition is true
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    @_disfavoredOverload
    func customAlert<Item, Title, Content, Actions>(
        _ title: @escaping (Item) -> Title,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder actions: @escaping (Item) -> Actions
    ) -> some View where Title: StringProtocol, Content: View, Actions: View {
        self.customAlert({ item in Text(title(item)) }, item: item, content: content, actions: actions)
    }
    
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - title: A `ViewBuilder` returing the alerts title.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Item, Content, Actions>(
        item: Binding<Item?>,
        @ViewBuilder title: @escaping (Item) -> Text?,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder actions: @escaping (Item) -> Actions
    ) -> some View where Content: View, Actions: View {
        self.customAlert({ title($0) }, item: item, content: content, actions: actions)
    }
}

public extension View {
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: A `ViewBuilder` returing the alerts title.
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - windowScene: The window scene to present the alert on.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Item, Content, Actions>(
        @ViewBuilder _ title: @escaping (Item) -> Text? = { _ in nil },
        item: Binding<Item?>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder actions: @escaping (Item) -> Actions
    ) -> some View where Content: View, Actions: View {
        modifier(
            CustomAlertHandler(
                item: item,
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
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - windowScene: The window scene to present the alert on.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Item, Content, Actions>(
        _ title: @escaping (Item) -> LocalizedStringKey,
        item: Binding<Item?>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder actions: @escaping (Item) -> Actions
    ) -> some View where Content: View, Actions: View {
        self.customAlert({ item in Text(title(item)) }, item: item, on: windowScene, content: content, actions: actions)
    }
    
    /// Presents an alert when a given condition is true
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - windowScene: The window scene to present the alert on.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    @_disfavoredOverload
    func customAlert<Item, Title, Content, Actions>(
        _ title: @escaping (Item) -> Title,
        item: Binding<Item?>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder actions: @escaping (Item) -> Actions
    ) -> some View where Title: StringProtocol, Content: View, Actions: View {
        self.customAlert({ item in Text(title(item)) }, item: item, on: windowScene, content: content, actions: actions)
    }
    
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///    - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - windowScene: The window scene to present the alert on.
    ///   - title: A `ViewBuilder` returing the alerts title.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ViewBuilder` returning the alert's actions.
    @warn_unqualified_access
    func customAlert<Item, Content, Actions>(
        item: Binding<Item?>,
        on windowScene: UIWindowScene,
        @ViewBuilder title: @escaping (Item) -> Text?,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder actions: @escaping (Item) -> Actions
    ) -> some View where Content: View, Actions: View {
        self.customAlert({ title($0) }, item: item, on: windowScene, content: content, actions: actions)
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
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @warn_unqualified_access
    func customAlert<Item, Content>(
        _ title: Text? = nil,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Content: View {
        self.customAlert({ _ in title }, item: item, content: content, actions: { _ in /* no actions */ })
    }
    
    /// Presents an alert when a given condition is true, using
    /// a localized string key for a title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @warn_unqualified_access
    func customAlert<Item, Content>(
        _ title: @escaping (Item) -> LocalizedStringKey,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Content: View {
        self.customAlert({ Text(title($0)) }, item: item, content: content, actions: { _ in /* no actions */ })
    }
    
    /// Presents an alert when a given condition is true
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @warn_unqualified_access
    @_disfavoredOverload
    func customAlert<Item, Title, Content>(
        _ title: @escaping (Item) -> Title,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Title: StringProtocol, Content: View {
        self.customAlert({ Text(title($0)) }, item: item, content: content, actions: { _ in /* no actions */ })
    }
    
    /// Presents an alert when a given condition is true, using an optional text view for
    /// the title.
    ///
    /// All actions in an alert dismiss the alert after the action runs.
    ///
    /// - Parameters:
    ///    - item: A binding to an optional source of truth for the alert.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a alert that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the alert and replaces it with a new one
    ///     using the same process.
    ///   - title: A `ViewBuilder` returing the alerts title.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @warn_unqualified_access
    func customAlert<Item, Content>(
        item: Binding<Item?>,
        @ViewBuilder title: @escaping (Item) -> Text?,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Content: View {
        self.customAlert({ title($0) }, item: item, content: content, actions: { _ in /* no actions */ })
    }
}

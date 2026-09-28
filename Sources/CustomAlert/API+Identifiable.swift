//
//  API+Identifiable.swift
//  CustomAlert
//
//  Created by David Walter on 28.02.24.
//

import SwiftUI
import WindowKit

// MARK: - Default API

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
    ///   - actions: A `ActionBuilder` returning the alert's actions.
    @MainActor
    func customAlert<Item, Content>(
        _ title: @autoclosure @escaping () -> Text? = nil,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ActionBuilder actions: @escaping (Item) -> [CustomAlertAction]
    ) -> some View where Item: Identifiable, Content: View {
        modifier(
            CustomAlertItemHandler(
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
    ///   - actions: A `ActionBuilder` returning the alert's actions.
    @MainActor
    func customAlert<Item, Content>(
        _ title: LocalizedStringKey,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ActionBuilder actions: @escaping (Item) -> [CustomAlertAction]
    ) -> some View where Item: Identifiable, Content: View {
        customAlert(Text(title), item: item, content: content, actions: actions)
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
    ///   - actions: A `ActionBuilder` returning the alert's actions.
    @MainActor
    @_disfavoredOverload
    func customAlert<Item, Title, Content>(
        _ title: Title,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ActionBuilder actions: @escaping (Item) -> [CustomAlertAction]
    ) -> some View where Item: Identifiable, Title: StringProtocol, Content: View {
        customAlert(Text(title), item: item, content: content, actions: actions)
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
    ///   - title: Callback for the optional title of the alert.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ActionBuilder` returning the alert's actions.
    @MainActor
    func customAlert<Item, Content>(
        item: Binding<Item?>,
        title: @escaping () -> Text?,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ActionBuilder actions: @escaping (Item) -> [CustomAlertAction]
    ) -> some View where Item: Identifiable, Content: View {
        customAlert(title(), item: item, content: content, actions: actions)
    }
}

// MARK: - WindowScene API

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
    ///   - windowScene: The window scene to present the alert on.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ActionBuilder` returning the alert's actions.
    @MainActor
    func customAlert<Item, Content>(
        _ title: @autoclosure @escaping () -> Text? = nil,
        item: Binding<Item?>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ActionBuilder actions: @escaping (Item) -> [CustomAlertAction]
    ) -> some View where Item: Identifiable, Content: View {
        modifier(
            CustomAlertItemHandler(
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
    ///   - actions: A `ActionBuilder` returning the alert's actions.
    @MainActor
    func customAlert<Item, Content>(
        _ title: LocalizedStringKey,
        item: Binding<Item?>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ActionBuilder actions: @escaping (Item) -> [CustomAlertAction]
    ) -> some View where Item: Identifiable, Content: View {
        customAlert(Text(title), item: item, on: windowScene, content: content, actions: actions)
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
    ///   - actions: A `ActionBuilder` returning the alert's actions.
    @MainActor
    @_disfavoredOverload
    func customAlert<Item, Title, Content>(
        _ title: Title,
        item: Binding<Item?>,
        on windowScene: UIWindowScene,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ActionBuilder actions: @escaping (Item) -> [CustomAlertAction]
    ) -> some View where Item: Identifiable, Title: StringProtocol, Content: View {
        customAlert(Text(title), item: item, on: windowScene, content: content, actions: actions)
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
    ///   - title: Callback for the optional title of the alert.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    ///   - actions: A `ActionBuilder` returning the alert's actions.
    @MainActor
    func customAlert<Item, Content>(
        item: Binding<Item?>,
        on windowScene: UIWindowScene,
        title: @escaping () -> Text?,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ActionBuilder actions: @escaping (Item) -> [CustomAlertAction]
    ) -> some View where Item: Identifiable, Content: View {
        customAlert(title(), item: item, on: windowScene, content: content, actions: actions)
    }
}

// MARK: - Convenience API

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
    @MainActor
    func customAlert<Item, Content>(
        _ title: Text? = nil,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Item: Identifiable, Content: View {
        customAlert(title, item: item, content: content, actions: { _ in /* no actions */ })
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
    @MainActor
    func customAlert<Item, Content>(
        _ title: LocalizedStringKey,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Item: Identifiable, Content: View {
        customAlert(Text(title), item: item, content: content, actions: { _ in /* no actions */ })
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
    @MainActor
    @_disfavoredOverload
    func customAlert<Item, Title, Content>(
        _ title: Title,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Item: Identifiable, Title: StringProtocol, Content: View {
        customAlert(Text(title), item: item, content: content, actions: { _ in /* no actions */ })
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
    ///   - title: Callback for the optional title of the alert.
    ///   - content: A `ViewBuilder` returing the alerts main view.
    @MainActor
    func customAlert<Item, Content>(
        item: Binding<Item?>,
        title: @escaping () -> Text?,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Item: Identifiable, Content: View {
        customAlert(title(), item: item, content: content, actions: { _ in /* no actions */ })
    }
}

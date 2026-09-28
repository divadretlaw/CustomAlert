//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI

/// Custom Alert
@MainActor public struct CustomAlert<Content>: View where Content: View {
    @Environment(\.customAlertConfiguration) private var configuration
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    @Binding var isPresented: Bool

    let title: Text?
    let content: Content
    let actions: [CustomAlertAction]

    // Size holders to enable scrolling of the content if needed
    @State private var viewSize: CGSize = .zero
    @State private var safeAreaInsets: EdgeInsets = .zero
    @State private var contentSize: CGSize = .zero
    @State private var actionsSize: CGSize = .zero

    // ID to redraw the alert if needed
    @State private var alertId: Int = 0
    // Tracks if the alert content fits in screen
    @State private var fitInScreen = false
    // Used to animate the appearance
    @State private var isShowing = false

    public init(
        isPresented: Binding<Bool>,
        title: @escaping () -> Text?,
        @ViewBuilder content: () -> Content,
        @ActionBuilder actions: () -> [CustomAlertAction]
    ) {
        self._isPresented = isPresented
        self.title = title()
        self.content = content()
        self.actions = actions()
    }

    public init(
        title: @autoclosure @escaping () -> Text?,
        @ViewBuilder content: () -> Content,
        @ViewBuilder actions: () -> [CustomAlertAction]
    ) {
        self._isPresented = .constant(true)
        self.title = title()
        self.content = content()
        self.actions = actions()
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                BackgroundView(background: configuration.background)
                    .edgesIgnoringSafeArea(.all)
                    .accessibilityAddTraits(configuration.dismissOnBackgroundTap ? [.isButton] : [])
                    .onTapGesture {
                        if configuration.dismissOnBackgroundTap {
                            isPresented = false
                        }
                    }
                    .accessibilityAddTraits(.isButton)

                VStack(spacing: 0) {
                    if configuration.alignment.isTop {
                        Spacer()
                    }

                    if isShowing {
                        makeAlert()
                            .animation(nil, value: height)
                            .id(alertId)
                            #if CUSTOM_ALERT_DESIGN
                            .opacity(0.5)
                            #endif
                    }

                    if configuration.alignment.isBottom {
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: proxy.totalWidth, maxHeight: proxy.totalHeight)
            .captureTotalSize($viewSize)
        }
        .captureSafeAreaInsets($safeAreaInsets)
        .onAppear {
            if configuration.animateTransition {
                withAnimation {
                    isShowing = true
                }
            } else {
                isShowing = true
            }
        }
    }

    func makeAlert() -> some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack(alignment: configuration.alert.horizontalAlignment, spacing: configuration.alert.spacing(state)) {
                        if let title {
                            title
                                .font(configuration.alert.titleFont)
                                .foregroundStyle(configuration.alert.titleColor)
                                .multilineTextAlignment(configuration.alert.textAlignment)
                        }
                        content
                            .font(configuration.alert.contentFont)
                            .foregroundStyle(configuration.alert.contentColor)
                            .multilineTextAlignment(configuration.alert.textAlignment)
                            .frame(maxWidth: .infinity, alignment: configuration.alert.frameAlignment)
                    }
                    .foregroundColor(.primary)
                    .padding(configuration.alert.padding(state))
                    .frame(maxWidth: .infinity)
                    .captureSize($contentSize)
                    // Force `Environment.isEnabled` to `true` because outer ScrollView is most likely disabled
                    .environment(\.isEnabled, true)
                }
                .frame(height: height)
                .onChange(of: contentSize) { contentSize in
                    fitInScreen = contentSize.height <= proxy.size.height
                }
                .scrollViewDisabled(fitInScreen)
            }
            .frame(height: height)

            makeActions()
                .captureSize($actionsSize)
        }
        .onAlertDismiss {
            isPresented = false
        }
        .frame(minWidth: minWidth, maxWidth: maxWidth)
        .background(BackgroundView(background: configuration.alert.background))
        .cornerRadius(configuration.alert.cornerRadius)
        .shadow(configuration.alert.shadow)
        .padding(configuration.padding)
        .transition(configuration.transition)
        .animation(.default, value: isPresented)
        .onChange(of: dynamicTypeSize) { _ in
            redrawAlert()
        }
    }

    func makeActions() -> some View {
        VStack(spacing: 0) {
            switch configuration.alert.dividerVisibility {
            case .automatic:
                if !fitInScreen {
                    Divider()
                }
            case .hidden:
                EmptyView()
            case .visible:
                Divider()
            }

            Group {
                if actions.count <= 2, #available(iOS 16.0, visionOS 1.0, *) {
                    ViewThatFits(in: .horizontal) {
                        ActionHStack(actions: actions.reversed())
                        ActionVStack(actions: actions)
                    }
                } else {
                    ActionVStack(actions: actions)
                }
            }
            .padding(configuration.alert.actionPadding)
        }
        .buttonStyle(.alert)
    }

    var state: CustomAlertState {
        CustomAlertState(dynamicTypeSize: dynamicTypeSize, isScrolling: !fitInScreen)
    }

    // MARK: Sizes

    var height: CGFloat {
        // View height - padding top and bottom - actions height - extra padding
        let maxHeight = viewSize.height
            - configuration.padding.top
            - configuration.padding.bottom
            - safeAreaInsets.top
            - safeAreaInsets.bottom
            - actionsSize.height
            - 20
        let min = min(maxHeight, contentSize.height)
        return max(min, 0)
    }

    var minWidth: CGFloat {
        // View width - padding leading and trailing
        let maxWidth = viewSize.width
            - configuration.padding.leading
            - configuration.padding.trailing
        // Make sure it fits in the content
        let min = min(maxWidth, contentSize.width)
        return max(min, 0)
    }

    var maxWidth: CGFloat {
        // View width - padding leading and trailing
        let maxWidth = viewSize.width
            - configuration.padding.leading
            - configuration.padding.trailing
            - safeAreaInsets.leading
            - safeAreaInsets.trailing
        // Make sure it fits in the content
        let min = min(maxWidth, contentSize.width)
        return max(min, configuration.alert.minWidth(state))
    }

    // MARK: - Helper

    func calculateAlertId() {
        var hasher = Hasher()
        hasher.combine(dynamicTypeSize)
        alertId = hasher.finalize()
    }

    func redrawAlert() {
        // Reset calculated sizes
        contentSize = .zero
        actionsSize = .zero
        // Force redraw
        calculateAlertId()
    }
}

#if DEBUG
#Preview("Default") {
    CustomAlert(isPresented: .constant(true)) {
        Text("Preview")
    } content: {
        Text("Content")
    } actions: {
        Button {
        } label: {
            Text("OK")
        }
        Button {
        } label: {
            Text("Cancel")
        }
    }
}

#Preview("Lorem Ipsum") {
    CustomAlert(isPresented: .constant(true)) {
        Text("Preview")
    } content: {
        Text(String.loremIpsum)
    } actions: {
        Button {
        } label: {
            Text("OK")
        }
    }
}
#endif

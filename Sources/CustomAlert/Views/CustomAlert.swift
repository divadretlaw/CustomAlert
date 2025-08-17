//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI

/// Custom Alert
@MainActor public struct CustomAlert<Content, Actions>: View where Content: View, Actions: View {
    @Environment(\.customAlertConfiguration) private var configuration
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @Binding var isPresented: Bool
    var title: Text?
    var content: Content
    var actions: Actions
    
    // Size holders to enable scrolling of the content if needed
    @State private var viewSize: CGSize = .zero
    @State private var safeAreaInsets: EdgeInsets = .zero
    @State private var contentSize: CGSize = .zero
    @State private var actionsSize: CGSize = .zero
    @State private var alertId: Int = 0
    
    @State private var fitInScreen = false
    
    // Used to animate the appearance
    @State private var isShowing = false
    
    public init(
        isPresented: Binding<Bool>,
        title: @escaping () -> Text?,
        @ViewBuilder content: () -> Content,
        @ViewBuilder actions: () -> Actions
    ) {
        self._isPresented = isPresented
        self.title = title()
        self.content = content()
        self.actions = actions()
    }
    
    public init(
        title: @autoclosure @escaping () -> Text?,
        @ViewBuilder content: () -> Content,
        @ViewBuilder actions: () -> Actions
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
                
                VStack(spacing: 0) {
                    if configuration.alignment.hasTopSpacer {
                        Spacer()
                    }
                    
                    if isShowing {
                        alert
                            .animation(nil, value: height)
                            .id(alertId)
                            #if CUSTOM_ALERT_DESIGN
                            .opacity(0.5)
                            #endif
                    }
                    
                    if configuration.alignment.hasBottomSpacer {
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
    
    var height: CGFloat {
        // View height - padding top and bottom - actions height
        let maxHeight = viewSize.height
            - configuration.padding.top
            - configuration.padding.bottom
            - safeAreaInsets.top
            - safeAreaInsets.bottom * 2
            - actionsSize.height
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
        
        if dynamicTypeSize.isAccessibilitySize {
            // Smallest AlertView should be 329
            return max(min, configuration.alert.accessibilityMinWidth)
        } else {
            // Smallest AlertView should be 270
            return max(min, configuration.alert.minWidth)
        }
    }
    
    var alertPadding: EdgeInsets {
        if dynamicTypeSize.isAccessibilitySize {
            configuration.alert.accessibilityContentPadding
        } else if !fitInScreen {
            configuration.alert.compactContentPadding
        } else {
            configuration.alert.contentPadding
        }
    }
    
    var alert: some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack(alignment: configuration.alert.horizontalAlignment, spacing: spacing) {
                        title?
                            .font(configuration.alert.titleFont)
                            .foregroundStyle(configuration.alert.titleColor)
                            .multilineTextAlignment(configuration.alert.textAlignment)
                        
                        content
                            .font(configuration.alert.contentFont)
                            .foregroundStyle(configuration.alert.contentColor)
                            .multilineTextAlignment(configuration.alert.textAlignment)
                            .frame(maxWidth: .infinity, alignment: configuration.alert.frameAlignment)
                    }
                    .foregroundColor(.primary)
                    .padding(alertPadding)
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
                _VariadicView.Tree(ActionLayout()) {
                    actions
                }
                .padding(configuration.alert.buttonPadding)
            }
            .buttonStyle(.alert)
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

    var spacing: CGFloat {
        if fitInScreen {
            configuration.alert.spacing
        } else {
            configuration.alert.compactSpacing
        }
    }
}

@MainActor struct ActionLayout: _VariadicView_ViewRoot {
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

private extension VerticalAlignment {
    var hasTopSpacer: Bool {
        switch self {
        case .top, .firstTextBaseline:
            return false
        default:
            return true
        }
    }
    
    var hasBottomSpacer: Bool {
        switch self {
        case .bottom, .lastTextBaseline:
            return false
        default:
            return true
        }
    }
}

private extension GeometryProxy {
    var totalWidth: CGFloat {
        size.width + safeAreaInsets.leading + safeAreaInsets.trailing
    }
    
    var totalHeight: CGFloat {
        size.height + safeAreaInsets.top + safeAreaInsets.bottom
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

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
            - safeAreaInsets.bottom
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
        } else {
            configuration.alert.contentPadding
        }
    }
    
    var alert: some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack(alignment: configuration.alert.horizontalAlignment, spacing: configuration.alert.spacing) {
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

#Preview("Scroll Content") {
    CustomAlert(isPresented: .constant(true)) {
        Text("Preview")
    } content: {
        Text(
            """
            Lorem ipsum odor amet, consectetuer adipiscing elit. Alacinia curae euismod amet; felis amet vitae elementum. Nec aptent vestibulum fusce gravida justo penatibus. Ad suscipit dui nostra pharetra mus finibus porttitor eget ullamcorper. Ipsum leo cubilia interdum elementum felis. Vulputate ornare duis aliquet erat curabitur tempor. Efficitur proin cursus porta dictum, gravida diam donec cursus. Proin cubilia penatibus duis vulputate est semper luctus. Penatibus nascetur dui ad rhoncus neque.
            
            Curae molestie etiam parturient taciti ex curae nostra. Orci elementum integer fusce vitae parturient duis venenatis. Elit venenatis magnis dolor blandit elit tristique. Lacinia sapien fusce; sodales mi aptent dictum semper. Rutrum leo malesuada est ligula placerat pellentesque morbi magna. Eleifend lorem torquent placerat cubilia gravida cursus sapien? Fusce semper inceptos id semper orci viverra eget bibendum.
            
            Mollis duis nascetur ex inceptos fermentum leo. Dis sodales ex potenti sodales eu facilisis volutpat. Mus ornare eros senectus torquent ultrices nullam. Bibendum fringilla dignissim est odio pretium aliquam penatibus aenean. Congue justo et sociosqu sit fames taciti magnis. Netus sem imperdiet; lacus vivamus finibus fusce habitant? Elementum habitasse duis eu dapibus facilisis placerat sit pulvinar. Est vehicula suscipit pellentesque parturient nec sapien habitasse. Nostra adipiscing ut posuere, bibendum sed hendrerit tincidunt consectetur.
            """
        )
    } actions: {
        Button {
        } label: {
            Text("OK")
        }
    }
}

#Preview("Custom") {
    CustomAlert(isPresented: .constant(true)) {
        Text("Preview")
    } content: {
        Text("Content")
    } actions: {
        MultiButton {
            Button {
            } label: {
                Text("Cancel")
            }
            Button {
            } label: {
                Text("OK")
            }
        }
    }
    .environment(\.customAlertConfiguration, .create { configuration in
        configuration.background = .blurEffect(.dark)
        configuration.padding = EdgeInsets()
        configuration.alert = .create { alert in
            alert.background = .color(.white)
            alert.cornerRadius = 4
            alert.contentPadding = EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20)
            alert.minWidth = 300
            alert.titleFont = .headline
            alert.contentFont = .subheadline
            alert.alignment = .leading
            alert.spacing = 10
        }
        configuration.button = .create { button in
            button.tintColor = .purple
            button.padding = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            button.font = .callout.weight(.semibold)
            button.hideDivider = true
        }
    })
}

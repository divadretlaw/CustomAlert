//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import SwiftUI

/// Custom Alert
struct CustomAlert<Content, Actions>: View where Content: View, Actions: View {
    @Environment(\.customAlertConfiguration) private var configuration
    
    @Binding var isPresented: Bool
    var title: Text?
    var content: Content
    var actions: Actions
    
    // Size holders to enable scrolling of the content if needed
    @State private var viewSize: CGSize = .zero
    @State private var contentSize: CGSize = .zero
    @State private var actionsSize: CGSize = .zero
    
    @State private var fitInScreen = false
    
    // Used to animate the appearance
    @State private var isShowing = false
    
    init(
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
    
    var body: some View {
        ZStack {
            BackgroundView(background: configuration.background)
                .edgesIgnoringSafeArea(.all)
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
                    alert.animation(nil, value: height)
                }
                
                if configuration.alignment.hasBottomSpacer {
                    Spacer()
                }
            }
        }
        .captureSize($viewSize)
        .onAppear {
            withAnimation {
                isShowing = true
            }
        }
    }
    
    var height: CGFloat {
        // View height - padding top and bottom - actions height
        let maxHeight = viewSize.height
            - configuration.padding.leading
            - configuration.padding.trailing
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
        // Make sure it fits in the content
        let min = min(maxWidth, contentSize.width)
        // Smallest AlertView should be 270
        return max(min, configuration.alert.minWidth)
    }
    
    var alert: some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack(alignment: configuration.alert.horizontalAlignment, spacing: configuration.alert.spacing) {
                        title?
                            .font(configuration.alert.titleFont)
                            .multilineTextAlignment(configuration.alert.textAlignment)
                        
                        content
                            .font(configuration.alert.contentFont)
                            .multilineTextAlignment(configuration.alert.textAlignment)
                            .frame(maxWidth: .infinity, alignment: configuration.alert.frameAlignment)
                    }
                    .foregroundColor(.primary)
                    .padding(configuration.alert.padding)
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
            
            _VariadicView.Tree(ActionLayout()) {
                actions
            }
            .onAlertDismiss {
                isPresented = false
            }
            .buttonStyle(.alert)
            .captureSize($actionsSize)
        }
        .frame(minWidth: minWidth, maxWidth: maxWidth)
        .background(BackgroundView(background: configuration.alert.background))
        .cornerRadius(configuration.alert.cornerRadius)
        .padding(configuration.padding)
        .transition(configuration.transition)
        .animation(.default, value: isPresented)
    }
}

struct ActionLayout: _VariadicView_ViewRoot {
    @Environment(\.customAlertConfiguration) private var configuration
    
    func body(children: _VariadicView.Children) -> some View {
        VStack(spacing: 0) {
            ForEach(children) { child in
                if !configuration.button.hideDivider {
                    Divider()
                }
                child
            }
        }
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(isPresented: .constant(true)) {
            Text("Preview")
        } content:{
            Text("Content")
        } actions: {
            Button {
            } label: {
                Text("OK")
            }
        }
        .previewDisplayName("Default")
        
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
                alert.padding = EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20)
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
        .previewDisplayName("Custom")
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

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
    
    var title: Text?
    @Binding var isPresented: Bool
    @ViewBuilder var content: () -> Content
    @ViewBuilder var actions: () -> Actions
    
    // Size holders to enable scrolling of the content if needed
    @State private var viewSize: CGSize = .zero
    @State private var contentSize: CGSize = .zero
    @State private var actionsSize: CGSize = .zero
    
    @State private var fitInScreen = false
    
    // Used to animate the appearance
    @State private var isShowing = false
    
    var body: some View {
        ZStack {
            BackgroundView(background: configuration.windowBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()
                if isShowing {
                    alert
                        .animation(nil, value: height)
                }
                Spacer()
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
            - configuration.alertPadding.leading
            - configuration.alertPadding.trailing
            - actionsSize.height
        let min = min(maxHeight, contentSize.height)
        return max(min, 0)
    }
    
    var minWidth: CGFloat {
        // View width - padding leading and trailing
        let maxWidth = viewSize.width
            - configuration.alertPadding.leading
            - configuration.alertPadding.trailing
        // Make sure it fits in the content
        let min = min(maxWidth, contentSize.width)
        return max(min, 0)
    }
    
    var maxWidth: CGFloat {
        // View width - padding leading and trailing
        let maxWidth = viewSize.width
            - configuration.alertPadding.leading
            - configuration.alertPadding.trailing
        // Make sure it fits in the content
        let min = min(maxWidth, contentSize.width)
        // Smallest AlertView should be 270
        return max(min, configuration.minWidth)
    }
    
    var alert: some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack(spacing: 4) {
                        title?
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        
                        content()
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundColor(.primary)
                    .padding(configuration.contentPadding)
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
            
            _VariadicView.Tree(ContentLayout(), content: actions)
                .buttonStyle(.alert(isPresented: $isPresented))
                .captureSize($actionsSize)
        }
        .frame(minWidth: minWidth, maxWidth: maxWidth)
        .background(BackgroundView(background: configuration.background))
        .cornerRadius(configuration.cornerRadius)
        .padding(configuration.alertPadding)
        .transition(.opacity.combined(with: .scale(scale: 1.1)))
        .animation(.default, value: isPresented)
    }
}

struct ContentLayout: _VariadicView_ViewRoot {
    @Environment(\.customAlertConfiguration) private var configuration
    
    func body(children: _VariadicView.Children) -> some View {
        VStack(spacing: 0) {
            ForEach(children) { child in
                if !configuration.buttonConfiguration.hideDivider {
                    Divider()
                }
                child
            }
        }
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(title: Text("Preview"), isPresented: .constant(true)) {
            Text("Content")
        } actions: {
            Button {
            } label: {
                Text("OK")
            }
        }
        .previewDisplayName("Default")
        
        CustomAlert(title: nil, isPresented: .constant(true)) {
            VStack {
                Text("Preview")
                    .font(.title)
                Text("Content")
                    .font(.body)
            }
        } actions: {
            MultiButton {
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
        .environment(\.customAlertConfiguration, .create { configuration in
            configuration.background = .color(.white)
            configuration.windowBackground = .blurEffect(.dark)
            configuration.cornerRadius = 0
            configuration.contentPadding = EdgeInsets(top: 10, leading: 4, bottom: 10, trailing: 4)
            configuration.alertPadding = EdgeInsets()
            configuration.minWidth = 300
            configuration.buttonConfiguration = .create { button in
                button.tintColor = .green
                button.padding = EdgeInsets(top: 15, leading: 4, bottom: 15, trailing: 4)
                button.font = .title3.weight(.black)
                button.hideDivider = true
            }
        })
        .previewDisplayName("Custom")
    }
}


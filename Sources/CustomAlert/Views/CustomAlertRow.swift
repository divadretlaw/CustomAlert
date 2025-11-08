//
//  CustomAlertRow.swift
//  CustomAlert
//
//  Created by David Walter on 30.04.22.
//

import SwiftUI

/// Display a custom alert inlined into a `List`
public struct CustomAlertRow<Content>: View where Content: View {
    @Environment(\.customAlertConfiguration) private var configuration
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    @Binding var isPresented: Bool

    let content: Content
    let actions: [CustomAlertAction]

    public var body: some View {
        if isPresented {
            VStack(alignment: configuration.alert.horizontalAlignment, spacing: 0) {
                content
                switch configuration.alert.dividerVisibility {
                case .hidden, .automatic:
                    EmptyView()
                case .visible:
                    Divider()
                }
                ForEach(Array(actions.enumerated()), id: \.offset) { _, action in
                    action
                }
                .padding(configuration.alert.actionPadding)
            }
            .buttonStyle(.alert)
            .listRowInsets(.zero)
        }
    }

    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction]
    ) {
        self._isPresented = isPresented
        self.content = content()
        self.actions = actions()
    }

    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ActionBuilder actions: @escaping () -> [CustomAlertAction]
    ) {
        self._isPresented = .constant(true)
        self.content = content()
        self.actions = actions()
    }

    var state: CustomAlertState {
        CustomAlertState(dynamicTypeSize: dynamicTypeSize, isScrolling: false)
    }
}

@available(iOS 17.0, visionOS 1.0, *)
#Preview {
    @Previewable @State var isPresented = false
    List {
        Section {
            SwiftUI.Button {
                isPresented = true
            } label: {
                Text("Show Custom Alert Row")
            }
        }
        Section {
            CustomAlertRow(isPresented: $isPresented) {
                Text("Hello World")
                    .padding()
            } actions: {
                MultiButton {
                    Button(role: .cancel) {
                        isPresented = false
                        print("Cancel")
                    } label: {
                        Text("Cancel")
                    }
                    Button {
                        isPresented = false
                        print("OK")
                    } label: {
                        Text("OK")
                    }
                }
            }
        }
    }
    .animation(.default, value: isPresented)
}

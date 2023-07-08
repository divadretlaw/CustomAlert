//
//  WrappedCustomAlert.swift
//  CustomAlert
//
//  Created by David Walter on 28.06.23.
//

import SwiftUI
import WindowSceneReader

struct WrappedCustomAlert<Content, Actions>: View where Content: View, Actions: View {
    var title: Text?
    @Binding var isPresented: Bool
    var content: () -> Content
    var actions: () -> Actions
    
    var body: some View {
        WindowSceneReader { windowScene in
            Color.clear
                .customAlert(title, isPresented: $isPresented, on: windowScene, content: content, actions: actions)
        }
    }
}

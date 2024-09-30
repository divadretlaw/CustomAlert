//
//  OnSimultaneousTapGesture.swift
//  CustomAlert
//
//  Created by David Walter on 05.04.24.
//

import SwiftUI

extension View {
    func onSimultaneousTapGesture(
        count: Int = 1,
        perform action: @escaping () -> Void
    ) -> some View {
        modifier(SimultaneousTapGestureViewModifier(count: count, perform: action))
    }
}

private struct SimultaneousTapGestureViewModifier: ViewModifier {
    let count: Int
    let action: () -> Void
    
    init(
        count: Int,
        perform action: @escaping () -> Void
    ) {
        self.count = count
        self.action = action
    }
    
    func body(content: Content) -> some View {
        #if compiler(<6.0)
        content
            .overlay(
                SimultaneousTapGesture(
                    numberOfTapsRequired: count,
                    action: action
                )
            )
        #else
        if #available(iOS 18.0, *) {
            content
                .simultaneousGesture(simultaneousTapGesture)
        } else {
            content
                .overlay(
                    SimultaneousTapGesture(
                        numberOfTapsRequired: count,
                        action: action
                    )
                )
        }
        #endif
    }
    
    var simultaneousTapGesture: some Gesture {
        TapGesture().onEnded {
            action()
        }
    }
}

private struct SimultaneousTapGesture: UIViewRepresentable {
    let numberOfTapsRequired: Int
    let action: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.tap)
        )
        tapGestureRecognizer.numberOfTapsRequired = numberOfTapsRequired
        tapGestureRecognizer.delegate = context.coordinator
        view.addGestureRecognizer(tapGestureRecognizer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        let action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        @objc func tap() {
            action()
        }
        
        // MARK: UIGestureRecognizerDelegate
        
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return false
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return false
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            return true
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
            return true
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
            return true
        }
    }
}

//
//  AlertWindow.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import UIKit
import SwiftUI

enum AlertWindow {
    static var allWindows: [UIWindowScene: UIWindow] = [:]
    
    static func present<Content>(on windowScene: UIWindowScene, view: () -> Content) where Content: View {
        guard allWindows[windowScene] == nil else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        allWindows[windowScene] = window
        
        let hostingController = UIHostingController(rootView: view())
        hostingController.view.backgroundColor = .clear
        hostingController.modalTransitionStyle = .crossDissolve
        hostingController.modalPresentationStyle = .fullScreen
        
        window.rootViewController = UIViewController(nibName: nil, bundle: nil)
        window.windowLevel = .alert
        window.backgroundColor = .clear
        window.overrideUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle

        window.subviews.forEach { $0.isHidden = true }
        window.makeKeyAndVisible()
        
        DispatchQueue.main.async {
            window.rootViewController?.present(hostingController, animated: true)
        }
    }
    
    static func dismiss(on windowScene: UIWindowScene?) {
        if let windowScene = windowScene {
            guard let window = allWindows[windowScene] else { return }
            window.isHidden = true
            allWindows[windowScene] = nil
        } else {
            dismiss()
        }
    }
    
    static func dismiss() {
        allWindows.forEach { key, value in
            dismiss(on: key)
        }
    }
}

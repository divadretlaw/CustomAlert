//
//  AlertWindow.swift
//  CustomAlert
//
//  Created by David Walter on 03.04.22.
//

import UIKit
import SwiftUI

enum AlertWindow {
    static var window: UIWindow?
    
    static func present<Content>(_ view: Content) where Content: View {
        guard let window = createWindow() else {
            print("The hosting window could not be created. This is a bug.")
            return
        }
        
        self.window = window
        
        let hostingController = UIHostingController(rootView: view)
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
    
    static func dismiss() {
        window?.isHidden = true
        window = nil
    }
    
    static func createWindow() -> UIWindow? {
        let scene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
        
        guard let windowScene = scene else { return nil }
        return UIWindow(windowScene: windowScene)
    }
}


//
//  iOS26CompatibleButtonWrapper.swift
//  CustomAlert
//
//  iOS 26 beta compatibility fix for button actions in modal presentations
//

import SwiftUI

/// iOS 26 beta compatibility wrapper for CustomAlert button actions
struct iOS26CompatibleButtonWrapper<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        if isIOS26Beta {
            // iOS 26 beta workaround: Replace broken button actions with working tap gesture
            content
                .contentShape(Rectangle())
                .onTapGesture {
                    isPresented = false
                }
        } else {
            content
        }
    }
    
    /// Detects iOS 26 beta based on system version
    private var isIOS26Beta: Bool {
        let systemVersion = UIDevice.current.systemVersion
        let versionComponents = systemVersion.components(separatedBy: ".")
        
        guard let majorVersion = versionComponents.first,
              let major = Int(majorVersion) else {
            return false
        }
        
        return major >= 26
    }
}


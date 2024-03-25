//
//  CustomAlertConfiguration.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI

public struct CustomAlertConfiguration {
    /// The configuration of the alert view
    public var alert: Alert = .init()
    /// The configuration of the alert buttons
    public var button: Button = .init()
    /// The window background behind the alert
    public var background: CustomAlertBackground = .color(Color.black.opacity(0.2))
    /// The padding around the alert
    public var padding: EdgeInsets = EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
    /// The transition the alert appears with
    public var transition: AnyTransition = .opacity.combined(with: .scale(scale: 1.1))
    /// The vertical alginment of the alert
    public var alignment: VerticalAlignment = .center
    /// Allow dismissing the alert when tapping on the background
    public var dismissOnBackgroundTap: Bool = false
    
    /// Create a custom configuration
    /// 
    /// - Parameter configure: Callback to change the default configuration
    /// 
    /// - Returns: The customized ``CustomAlertConfiguration`` configuration
    public static func create(configure: (inout Self) -> Void) -> Self {
        var configuration = Self()
        configure(&configuration)
        return configuration
    }
    
    /// The default configuration
    public static var `default`: CustomAlertConfiguration {
        CustomAlertConfiguration()
    }
}

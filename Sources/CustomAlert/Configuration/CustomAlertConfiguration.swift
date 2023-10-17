//
//  CustomAlertConfiguration.swift
//  CustomAlert
//
//  Created by David Walter on 17.10.23.
//

import Foundation
import SwiftUI

public struct CustomAlertConfiguration {
    /// The window background of the alert
    public var background: CustomAlertBackground = .blurEffect(.regular)
    /// The window background behind the alert
    public var windowBackground: CustomAlertBackground = .color(Color.black.opacity(0.2))
    /// The corner radius of the alert
    public var cornerRadius: CGFloat = 13.3333
    /// The padding of the content of the alert
    public var contentPadding: EdgeInsets = EdgeInsets(top: 20, leading: 8, bottom: 20, trailing: 8)
    /// The padding of the alert
    public var alertPadding: EdgeInsets = EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
    /// The minimum width of the alert
    public var minWidth: CGFloat = 270
    /// The configuration of the alert buttons
    public var buttonConfiguration: CustomAlertButtonConfiguration = .init()
    
    /// Create a custom configuration
    /// - Parameter configure: Callback to change the default configuration
    /// 
    /// - Returns: The configured ``CustomAlertConfiguration``
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

//
//  ProcessInfoExtensions.swift
//  CustomAlert
//
//  Created by David Walter on 20.10.24.
//

import Foundation

extension ProcessInfo {
    var isiOSAppOnVision: Bool {
        NSClassFromString("UIWindowSceneGeometryPreferencesVision") != nil
    }
    
    var isiOSAppOnOtherPlatform: Bool {
        isiOSAppOnMac || isMacCatalystApp || isiOSAppOnVision
    }
}

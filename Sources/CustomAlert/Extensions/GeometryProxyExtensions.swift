//
//  GeometryProxyExtensions.swift
//  CustomAlert
//
//  Created by David Walter on 07.01.26.
//

import SwiftUI

extension GeometryProxy {
    var totalWidth: CGFloat {
        size.width + safeAreaInsets.leading + safeAreaInsets.trailing
    }

    var totalHeight: CGFloat {
        size.height + safeAreaInsets.top + safeAreaInsets.bottom
    }
}

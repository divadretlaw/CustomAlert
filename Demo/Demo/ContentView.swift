//
//  ContentView.swift
//  Demo
//
//  Created by David Walter on 19.08.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                SimpleAlerts()
                
                InputAlerts()
                
                MultiButtonAlerts()
                
                OtherAlerts()
                
                CustomAlerts()
            }
            .navigationTitle("Custom Alert")
        }
    }
}

#Preview {
    ContentView()
}

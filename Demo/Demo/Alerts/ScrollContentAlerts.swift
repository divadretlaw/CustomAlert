//
//  ScrollContentAlerts.swift
//  Demo
//
//  Created by David Walter on 24.01.25.
//

import SwiftUI
import CustomAlert

struct ScrollContentAlerts: View {
    @State private var showNative = false
    @State private var showCustom = false
    
    var body: some View {
        Section {
            Button {
                showNative = true
            } label: {
                DetailLabel("Native", detail: "SwiftUI native alert")
            }
            .alert("Native Alert", isPresented: $showNative) {
                Button(role: .cancel) {
                    print("Simple.Native - Cancel")
                } label: {
                    Text("Cancel")
                }
            } message: {
                Text(
                    """
                    Lorem ipsum odor amet, consectetuer adipiscing elit. Alacinia curae euismod amet; felis amet vitae elementum. Nec aptent vestibulum fusce gravida justo penatibus. Ad suscipit dui nostra pharetra mus finibus porttitor eget ullamcorper. Ipsum leo cubilia interdum elementum felis. Vulputate ornare duis aliquet erat curabitur tempor. Efficitur proin cursus porta dictum, gravida diam donec cursus. Proin cubilia penatibus duis vulputate est semper luctus. Penatibus nascetur dui ad rhoncus neque.

                    Curae molestie etiam parturient taciti ex curae nostra. Orci elementum integer fusce vitae parturient duis venenatis. Elit venenatis magnis dolor blandit elit tristique. Lacinia sapien fusce; sodales mi aptent dictum semper. Rutrum leo malesuada est ligula placerat pellentesque morbi magna. Eleifend lorem torquent placerat cubilia gravida cursus sapien? Fusce semper inceptos id semper orci viverra eget bibendum.

                    Mollis duis nascetur ex inceptos fermentum leo. Dis sodales ex potenti sodales eu facilisis volutpat. Mus ornare eros senectus torquent ultrices nullam. Bibendum fringilla dignissim est odio pretium aliquam penatibus aenean. Congue justo et sociosqu sit fames taciti magnis. Netus sem imperdiet; lacus vivamus finibus fusce habitant? Elementum habitasse duis eu dapibus facilisis placerat sit pulvinar. Est vehicula suscipit pellentesque parturient nec sapien habitasse. Nostra adipiscing ut posuere, bibendum sed hendrerit tincidunt consectetur.
                    """
                )
            }
            
            Button {
                showCustom = true
            } label: {
                DetailLabel("Custom", detail: "CustomAlert looking like native alert")
            }
            .customAlert("Custom Alert", isPresented: $showCustom) {
                Text(
                    """
                    Lorem ipsum odor amet, consectetuer adipiscing elit. Alacinia curae euismod amet; felis amet vitae elementum. Nec aptent vestibulum fusce gravida justo penatibus. Ad suscipit dui nostra pharetra mus finibus porttitor eget ullamcorper. Ipsum leo cubilia interdum elementum felis. Vulputate ornare duis aliquet erat curabitur tempor. Efficitur proin cursus porta dictum, gravida diam donec cursus. Proin cubilia penatibus duis vulputate est semper luctus. Penatibus nascetur dui ad rhoncus neque.

                    Curae molestie etiam parturient taciti ex curae nostra. Orci elementum integer fusce vitae parturient duis venenatis. Elit venenatis magnis dolor blandit elit tristique. Lacinia sapien fusce; sodales mi aptent dictum semper. Rutrum leo malesuada est ligula placerat pellentesque morbi magna. Eleifend lorem torquent placerat cubilia gravida cursus sapien? Fusce semper inceptos id semper orci viverra eget bibendum.

                    Mollis duis nascetur ex inceptos fermentum leo. Dis sodales ex potenti sodales eu facilisis volutpat. Mus ornare eros senectus torquent ultrices nullam. Bibendum fringilla dignissim est odio pretium aliquam penatibus aenean. Congue justo et sociosqu sit fames taciti magnis. Netus sem imperdiet; lacus vivamus finibus fusce habitant? Elementum habitasse duis eu dapibus facilisis placerat sit pulvinar. Est vehicula suscipit pellentesque parturient nec sapien habitasse. Nostra adipiscing ut posuere, bibendum sed hendrerit tincidunt consectetur.
                    """
                )
            } actions: {
                Button(role: .cancel) {
                    print("Simple.Custom - Cancel")
                } label: {
                    Text("Cancel")
                }
            }
        } header: {
            Text("Scroll Content")
        }
    }
}

#Preview {
    ScrollContentAlerts()
}

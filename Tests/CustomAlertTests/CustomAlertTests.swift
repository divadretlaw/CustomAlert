import Foundation
import SwiftUI
import CustomAlert

/// Compile-time guards: importing `CustomAlert` must not shadow `SwiftUI` types.
struct CompileTests {
    @MainActor private func button() {
        let button = Button("OK") {}
        let _: SwiftUI.Button<Text> = button
    }

    @MainActor private func hstack() {
        let stack = HStack {}
        let _: SwiftUI.HStack = stack
    }

    @MainActor private func vstack() {
        let stack = VStack {}
        let _: SwiftUI.VStack = stack
    }
}

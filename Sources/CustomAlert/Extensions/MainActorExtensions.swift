//
//  MainActorExtensions.swift
//  CustomAlert
//
//  Created by David Walter on 20.07.24.
//

import Foundation

extension MainActor {
    #if swift(<5.10)
    @_unavailableFromAsync
    private static func runUnsafely<T>(_ body: @MainActor () throws -> T) rethrows -> T {
        if #available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *) {
            return try MainActor.assumeIsolated(body)
        } else {
            dispatchPrecondition(condition: .onQueue(.main))
            return try withoutActuallyEscaping(body) { function in
                try unsafeBitCast(function, to: (() throws -> T).self)()
            }
        }
    }
    #endif
    
    /// Execute the given body closure on the main actor without enforcing MainActor isolation.
    ///
    /// The method will be dispatched in sync to the main-thread if its on a non-main thread.
    @_unavailableFromAsync
    static func runSync<T>(_ body: @MainActor () throws -> T) rethrows -> T where T: Sendable {
        if Thread.isMainThread {
            #if swift(>=5.10)
            try MainActor.assumeIsolated(body)
            #else
            try MainActor.runUnsafely(body)
            #endif
        } else {
            try DispatchQueue.main.sync {
                #if swift(>=5.10)
                try MainActor.assumeIsolated(body)
                #else
                try MainActor.runUnsafely(body)
                #endif
            }
        }
    }
}

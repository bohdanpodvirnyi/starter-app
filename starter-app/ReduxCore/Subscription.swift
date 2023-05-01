//
//  Subscription.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 01.05.2023.
//

import Foundation

/// Internal wrapper for State observation closure
final class Subscription<State>: Cancellable {
    private let action: (State) async -> Void
    private let cancelAction: (Subscription) async -> Void
    private var isCanceled: Bool = false
    
    init(
        _ action: @escaping (State) async -> Void,
        _ cancel: @escaping (Subscription) async -> Void
    ) {
        self.action = action
        self.cancelAction = cancel
    }
    
    func update(with state: State) async {
        await action(state)
    }
    
    /// Conformance to `Cancellable` protocol.
    public func cancel() {
        isCanceled = true
        Task {
            await cancelAction(self)
        }
    }
    
    deinit {
        guard isCanceled == false else { return }
        cancel()
    }
}

/// Allows Subscription to be compared and stored in sets and dicts.
/// Uses `ObjectIdentifier` to distinguish between subscribers
extension Subscription: Hashable {
    public static func ==(lhs: Subscription, rhs: Subscription) -> Bool {
        return lhs === rhs
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

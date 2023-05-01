//
//  Store.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 01.05.2023.
//

import Foundation

/// Store is a single mutation point of our app state.
public final class Store<State> {
    /// Current app state is stored here
    public private(set) var state: State
    
    /// Reducer is a rule to proceed from current state to a new one
    private let reducer: (State, Action) -> State
    
    private var dispatch: ((Action) async -> Void)?
    
    /// Store should notify everyone about state changes
    private var subscribers: Set<Subscription<State>> = []
    
    private let middlewares: [((Action) async -> Void, Action, State, State) -> Void]
    
    public init(
        state: State,
        reducer: @escaping (State, Action) -> State,
        middlewares: [((Action) async -> Void, Action, State, State) -> Void]
    ) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
        
        self.dispatch = { action in
            let oldState = self.state
            let newState = self.reducer(oldState, action)
            self.state = newState
            self.middlewares.forEach { middleware in
                middleware(self.dispatch, action, oldState, newState)
            }
            await withTaskGroup(of: Void.self) { group in
                for subscriber in self.subscribers {
                    group.addTask {
                        await subscriber.update(with: newState)
                    }
                }
            }
        }
    }
    
    /// Dispatch is async by nature.
    public func dispatch(action: Action) async {
        await self.dispatch?(action)
    }
    
    /// Attaches the specified action to the state updates.
    ///
    /// - Parameter action: The action to attach to watch for state updates.
    /// - Returns: An object with `Cancellable` conformance that makes it possible for a caller to cancel observation.
    public func observe(action: @escaping (State) -> Void) -> Cancellable {
        let subscription = Subscription(action, { [weak self] subscription in
            self?.subscribers.remove(subscription)
        })
        
        Task {
            subscribers.insert(subscription)
            await subscription.update(with: state)
        }
        
        return subscription
    }
}

//
//  StarterScreenFactory.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import Foundation

public struct StarterScreenFactory {
    private let store: Store<AppState>
    
    public init(store: Store<AppState>) {
        self.store = store
    }
    
    public func `default`() -> StarterViewController {
        let controller = StarterViewController()
        var cancelObserving: Cancellable?
        
        let dispatch = CommandWith { action in
            Task {
                await store.dispatch(action: action)
            }
        }
        
        let presenter = StarterPresenter(
            render: CommandWith { props in
                controller.render(props: props)
            }.dispatchedOnMain(),
            dispatch: dispatch,
            endObserving: Command { cancelObserving?.cancel() }
        )
        cancelObserving = store.observe(action: presenter.present)
        
        return controller
    }
}

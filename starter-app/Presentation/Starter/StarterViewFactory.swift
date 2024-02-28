//
//  StarterScreenFactory.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import Foundation
import ReduxCore

public struct StarterViewFactory {
    private let store: Store<AppState>
    
    public init(store: Store<AppState>) {
        self.store = store
    }
    
    public func `default`() -> StarterView {
        let view = StarterView()
        var cancelObserving: Cancellation?
        
        let processor = StarterProcessor(
            view: view,
            dispatch: CommandWith { action in
                store.dispatch(action: action)
            },
            endObserving: Command { cancelObserving?.cancel() }
        )
        cancelObserving = store.observe(with: processor.process(state:))
        return view
    }
}

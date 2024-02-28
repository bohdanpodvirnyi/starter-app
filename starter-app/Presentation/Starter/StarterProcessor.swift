//
//  StarterPresenter.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import Foundation
import ReduxCore

extension Actions {
    enum StarterProcessor {
        struct DidAppear: Action {}
    }
}

public struct StarterProcessor {
    let view: StarterView
    let dispatch: CommandWith<Action>
    let endObserving: Command?
    
    func process(state: AppState) {
        view.props.update(
            props: StarterView.Props(
                onAppear: CommandWith {
                    dispatch.perform(with: Actions.StarterProcessor.DidAppear())
                }
            )
        )
    }
}

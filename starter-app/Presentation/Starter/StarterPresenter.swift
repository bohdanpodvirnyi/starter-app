//
//  StarterPresenter.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import Foundation
import ReduxCore

public struct StarterPresenter {
    let render: CommandWith<StarterViewController.Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command?
    
    func present(state: AppState) {
        render.perform(
            with: StarterViewController.Props.initial
        )
    }
}

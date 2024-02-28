//
//  SceneDelegate.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import UIKit
import ReduxCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        StoreLocator.shared.dispatch(action: Actions.Scene.WillConnectToSession(scene: scene))
    }
}

extension Actions {
    enum Scene {
        struct WillConnectToSession: Action {
            public let scene: UIScene
        }
    }
}

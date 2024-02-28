//
//  AppDelegate.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import UIKit
import ReduxCore

// MARK: - App lifecycle actions
extension Actions {
    enum ApplicationDelegate {
        struct DidFinishLaunch: Action {}
        struct DidEnterBackground: Action {}
        struct DidBecomeActive: Action {}
        struct WillEnterForeground: Action {}
        struct ViewDidAppear: Action {}
    }
}

final class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureStore()
        StoreLocator.shared.dispatch(action: Actions.ApplicationDelegate.DidFinishLaunch())
        return true
    }
}

// MARK: - Store
private extension AppDelegate {
    private func configureStore() {
        let state = AppState.initial
        let store = Store(
            state: state,
            reducer: reduce,
            middlewares: [
                LoggerMiddleware().middleware(),
            ]
        )
        StoreLocator.populate(with: store)
    }
}

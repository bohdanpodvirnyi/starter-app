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
    enum Application {
        struct DidFinishLaunch: Action {}
        struct DidEnterBackground: Action {}
        struct DidBecomeActive: Action {}
        struct WillEnterForeground: Action {}
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureStore()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: - Store
private extension AppDelegate {
    private func configureStore() {
        let state = AppState.initial
        let coordinator = AppCoordinator()
        let store = Store(
            state: state,
            reducer: reduce,
            middlewares: [
                LoggerMiddleware().middleware(),
                CoordinatorMiddleware(handler: coordinator.handle).middleware(),
            ]
        )
        StoreLocator.populate(with: store)
    }
}

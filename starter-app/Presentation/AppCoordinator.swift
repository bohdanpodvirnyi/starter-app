//
//  AppCoordinator.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 2/28/24.
//

import UIKit
import ReduxCore

final class AppCoordinator: NSObject {
    private var window: UIWindow?
    private var navigationController: UINavigationController? {
        window?.rootViewController as? UINavigationController
    }
    
    private lazy var dispatch = CommandWith(action: store.dispatch)
    private lazy var store: Store<AppState> = StoreLocator.shared
    
    override init() {}
    
    func handle(_ state: AppState, action: Action) {
        switch action {
        case is Actions.Application.DidFinishLaunch:
            break
        case let action as Actions.Scene.WillConnectToSession:
            guard let windowScene = (action.scene as? UIWindowScene) else { return }
            
            let window = UIWindow(windowScene: windowScene)
            let navigationController = setupNavigation()
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        default:
            break
        }
    }
    
    private func setupNavigation() -> UINavigationController {
        let controller = StarterScreenFactory(store: store).default()
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
}

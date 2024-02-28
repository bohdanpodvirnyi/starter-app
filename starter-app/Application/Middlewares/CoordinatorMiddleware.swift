//
//  CoordinatorMiddleware.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 2/28/24.
//

import ReduxCore
import Foundation

final class CoordinatorMiddleware {
    private let handler: (AppState, Action) -> Void
    
    init(handler: @escaping (AppState, Action) -> Void) {
        self.handler = handler
    }
    
    func middleware() -> Middleware<AppState> {
        { (_, action, _, state) in
            DispatchQueue.main.async { self.handler(state, action) }
        }
    }
}

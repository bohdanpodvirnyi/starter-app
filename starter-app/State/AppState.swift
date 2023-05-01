//
//  AppState.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import Foundation

public struct AppState: Equatable {
    static let initial = AppState()
    
    public init() {}
}

public func reduce(_ state: AppState, with action: Action) -> AppState {
    switch action {
    default:
        return AppState()
    }
}

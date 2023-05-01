//
//  StoreLocator.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import Foundation

final class StoreLocator {
    private static var store: Store<AppState>?
    
    static func populate(with store: Store<AppState>) {
        self.store = store
    }
    
    static var shared: Store<AppState> {
        guard let store = store else {
            fatalError("Store is not populated into locator")
        }
        
        return store
    }
}

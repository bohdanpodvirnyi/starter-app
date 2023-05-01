//
//  Cancellation.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 01.05.2023.
//

import Foundation

/// A protocol that enables an object to be cancelled.
public protocol Cancellable {
    func cancel()
}

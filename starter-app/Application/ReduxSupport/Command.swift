//
//  Command.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import Foundation

public final class CommandWith<T> {
    public let id: String
    private let file: StaticString
    private let function: StaticString
    private let line: Int
    private let action: (T) -> Void
    
    public init(
        id: String = UUID().uuidString,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        action: @escaping (T) -> Void
    ) {
        self.id = id
        self.action = action
        self.function = function
        self.file = file
        self.line = line
    }
    
    public func perform(with value: T) {
        action(value)
    }
    
    public static var empty: CommandWith<T> {
        return CommandWith<T>(id: "empty") { _ in }
    }
}

public typealias Command = CommandWith<Void>

public extension CommandWith where T == Void {
    func perform() {
        perform(with: ())
    }
}

public extension CommandWith {
    func dispatched(on queue: DispatchQueue) -> CommandWith {
        return CommandWith { [action] value in
            queue.async {
                action(value)
            }
        }
    }
    
    func dispatchedOnMain() -> CommandWith {
        return CommandWith { [action] value in
            if Thread.isMainThread {
                action(value)
            } else {
                DispatchQueue.main.async {
                    action(value)
                }
            }
        }
    }
}

extension CommandWith: Equatable {
    public static func == (lhs: CommandWith<T>, rhs: CommandWith<T>) -> Bool {
        lhs.id == rhs.id
    }
}

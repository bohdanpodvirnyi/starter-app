//
//  LoggerMiddleware.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 2/28/24.
//

import Foundation
import ReduxCore
import os.log

struct LoggerMiddleware {
    func middleware() -> Middleware<AppState> {
        { _, action, _, _ in
            os_log(
                "%@",
                log: OSLog(subsystem: Bundle.main.bundleIdentifier ?? "", category: ""),
                type: .debug,
                action.debugDescription
            )
        }
    }
}

private extension Action {
    var debugDescription: String {
        "✳️ " + String(reflecting: type(of: self))
    }
}

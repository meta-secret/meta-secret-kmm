//
//  LoggerManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 05.01.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import OSLog

protocol LoggerManager {
    func log(_ message: String, _ method: String, isError: Bool)
}

extension LoggerManager {
    func log(_ message: String = "", _ method: String = #function, isError: Bool = false) {
        let className = String(describing: type(of: self))
        if isError {
            Logger().error("[\(className.capitalized)] -- \(method) -- \(message)")
        } else {
            Logger().info("[\(className.capitalized)] -- \(method) -- \(message)")
        }
    }
}

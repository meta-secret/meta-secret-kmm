//
//  AuthManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 08.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared
import OSLog

protocol AuthManagerProtocol {
    func checkAuth() -> AuthState
    func checkOnboardingState() -> Bool
    func setOnboardingState()
    
    func checkValetAvailability(name: String) -> Bool
    func register(with name: String)
}

class AuthManager: AuthManagerProtocol, LoggerManager {
    let logger: Logger = Logger()
    
    //TODO: Check AuthManagerApi address not to create multiple instance. and avoid race conditions
    var authManagerApi = AuthManagerApi(factory: DriverFactory())
    
    func checkAuth() -> AuthState {
        log()
        return authManagerApi.getAuthStatus()
    }
    
    func checkOnboardingState() -> Bool {
        Logger().info("AuthManagerProtocol -- checkOnboardingState")
        return authManagerApi.getOnboardingStatus()
    }
    
    func setOnboardingState() {
        return authManagerApi.setOnboardingCompletion(isCompleted: true)
    }

    func checkValetAvailability(name: String) -> Bool {
        return name != "Dima" && !name.isEmpty
    }
    
    func register(with name: String) {
        authManagerApi.setAuthStatus(name: name)
    }
}

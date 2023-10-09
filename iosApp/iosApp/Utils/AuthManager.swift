//
//  AuthManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 08.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

protocol AuthManagerProtocol {
    func checkAuth() -> AuthState
    func checkOnboardingState() -> Bool
    func setOnboardingState(isCompleted: Bool)
    
    func checkValetAvailability(name: String) -> Bool
    func register(with name: String)
}

class AuthManager: AuthManagerProtocol {
    //TODO: Check AuthManagerApi address not to create multiple instance. and avoid race conditions
    var authManagerApi = AuthManagerApi(factory: DriverFactory())
    
    func checkAuth() -> AuthState {
        return authManagerApi.getAuthStatus()
    }
    
    func checkOnboardingState() -> Bool {
        return authManagerApi.getOnboardingStatus()
    }
    
    func setOnboardingState(isCompleted: Bool) {
        return authManagerApi.setOnboardingCompletion(isCompleted: isCompleted)
    }
    
    
    
    func checkValetAvailability(name: String) -> Bool {
        return name != "Dima" && !name.isEmpty
    }
    
    func register(with name: String) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "Name")
    }
}

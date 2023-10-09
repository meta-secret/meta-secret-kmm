//
//  SplashViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 08.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

final class SplashViewModel {
    @Service private var authManager: AuthManagerProtocol
    
    func checkAuth() -> AuthState {
        return authManager.checkAuth()
    }
    
    func readOnboardingKey() -> Bool {
        return authManager.checkOnboardingState()
    }
}

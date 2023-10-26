//
//  SplashViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 08.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared
import Combine

final class SplashViewModel: ObservableObject {
    @Service private var authManager: AuthManagerProtocol
    @Service private var biometricManager: BiometricsManagerProtocol
    
    private var cancellable: Cancellable?
    
    @Published var navigateToOnboarding: Bool = false
    @Published var navigateToMain: Bool = false
    @Published var navigateToSignIn: Bool = false
    @Published var needAlert: Bool = false
    
    var errorBiometric: BiometricError? = nil
    
    func checkBiometric(completion: @escaping (Bool) -> Void) {
        guard biometricManager.canEvaluate() else {
            completion(false)
            return
        }

        cancellable = biometricManager.evaluate().sink { value in
            var (success, error) = value
            if success {
                error = nil
            } else {
                self.errorBiometric = error
            }
            completion(true)
        }
    }
    
    func checkAuth() -> AuthState {
        return authManager.checkAuth()
    }
    
    func readOnboardingKey() -> Bool {
        return authManager.checkOnboardingState()
    }
}

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
import OSLog
import SwiftUI

final class SplashViewModel: CommonViewModel {
    @Service private var authManager: AuthManagerProtocol
    @Service private var biometricManager: BiometricsManagerProtocol
    
    private var cancellable: Cancellable?
    
    @Published var navigateToOnboarding: Bool = false
    @Published var navigateToMain: Bool = false
    @Published var navigateToSignIn: Bool = false
    @Published var needAlert: Bool = false
    
    var errorBiometric: BiometricError? = nil
    
    override func onAppear() {
        log()
        checkBiometric { (success) in
            if let _ = self.errorBiometric {
                self.log("errorBiometric", isError: true)
                DispatchQueue.main.async {
                    self.needAlert = true
                }
            } else {
                self.log("Biometric ok")
                if self.readOnboardingKey() {
                    if self.checkAuth() == .alreadyRegistered {
                        self.navigateToMain = true
                    } else {
                        self.navigateToSignIn = true
                    }
                } else {
                    self.navigateToOnboarding = true
                }
            }
        }
    }
    
    func checkBiometric(completion: @escaping (Bool) -> Void) {
        log()
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
        self.log()
        return authManager.checkOnboardingState()
    }
}

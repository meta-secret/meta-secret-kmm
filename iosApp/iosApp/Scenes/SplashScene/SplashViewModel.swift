//
//  SplashViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 08.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

final class SplashViewModel {
    @Service private var authManager: AuthManagerProtocol
    
    func checkAuth() -> Bool {
        return authManager.checkAuth()
    }
}

//
//  AuthManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 08.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

protocol AuthManagerProtocol {
    func checkAuth() -> Bool
    func checkValetAvailability(name: String) -> Bool
    func register(with name: String)
}

class AuthManager: AuthManagerProtocol {
    func checkAuth() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Name") != nil
    }
    
    func checkValetAvailability(name: String) -> Bool {
        return name != "Dima" 
    }
    
    func register(with name: String) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "Name")
    }
}

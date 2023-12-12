//
//  ContentManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import UIKit
import shared
import OSLog

protocol ContentManagerProtocol {
    func getContentItems(by type: ItemType) -> [any CommonItemModel]
    func saveSecret(description: String, secret: String)
}

class ContentManager: ContentManagerProtocol {
    @Service private var userService: UsersServiceProtocol
    
    func getContentItems(by type: ItemType) -> [any CommonItemModel] {
    #warning("Need to implement Device Manager and Secrets Manager")
        var secrets = [SecretModel]()
        
        switch type {
        case .device:
            Logger().info("Get devices source")
            guard let mainVault = userService.mainVault else { return [] }
            Logger().info("Main vault \(mainVault.vaultName) & signatures count \(Int(mainVault.signatures?.count ?? 0))")
            let mainVaultSource = DeviceModel(name: mainVault.vaultName,
                                              deviceType: .iphone,
                                              deviceId: "",
                                              secretsCount: 0)
            
            return [mainVaultSource]
        case .secrets:
            return []
        }
    }
    
    func saveSecret(description: String, secret: String) {
        let defaults = UserDefaults.standard
        defaults.set(secret, forKey: description)
        
        var descriptions = defaults.array(forKey: "descriptions") ?? [String]()
        descriptions.append(description)
        
        defaults.set(descriptions, forKey: "descriptions")
    }
}

private extension ContentManager {
    func getAllSecrets() {
        
    }
}

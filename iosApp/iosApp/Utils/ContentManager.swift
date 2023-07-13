//
//  ContentManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import UIKit

protocol ContentManagerProtocol {
    func getContentItems(by type: ItemType) -> [any CommonItemModel]
    func saveSecret(description: String, secret: String)
}

class ContentManager: ContentManagerProtocol {
    func getContentItems(by type: ItemType) -> [any CommonItemModel] {
    #warning("Need to implement Device Manager and Secrets Manager")
        var secrets = [SecretModel]()
        
        switch type {
        case .device:
            let defaults = UserDefaults.standard
            let counter = defaults.array(forKey: "descriptions")?.count ?? 0
            return [DeviceModel(name: UIDevice.current.name, deviceType: .iphone, deviceId: UIDevice.current.identifierForVendor!.uuidString, secretsCount: "\(counter)")]
        case .secrets:
            let defaults = UserDefaults.standard
            let descriptions = (defaults.array(forKey: "descriptions") as? [String]) ?? [String]()
            for description in descriptions {
                let secret = defaults.string(forKey: description) ?? ""
                
                let randomInt = Int.random(in: 0..<3)
                let type = StrenghtType(rawValue: randomInt) ?? .weak
                secrets.append(SecretModel(description: description, secret: secret, strenghtType: type))
            }
            return secrets
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

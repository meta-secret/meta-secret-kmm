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
//            let defaults = UserDefaults.standard
//            let counter = defaults.array(forKey: "descriptions")?.count ?? 0
//            return [DeviceModel(name: UIDevice.current.name, deviceType: .iphone, deviceId: UIDevice.current.identifierForVendor!.uuidString, secretsCount: "\(counter)")]
            var items = [DeviceModel]()
            
            let iOSNumber = UserDefaults.standard.value(forKey: "iOSNumber") as! Int
            let deviceCount = UserDefaults.standard.value(forKey: "deviceCount") as! Int
            if deviceCount == 1 && iOSNumber == 1 {
                items.append(DeviceModel(name: "iPhoneSE", deviceType: .iphone, deviceId: "232F3207-3646-40FD-A2B8-9B574A6E6C32", secretsCount: "0"))
            } else if deviceCount == 2  {
                items.append(DeviceModel(name: "iPhoneSE", deviceType: .iphone, deviceId: "232F3207-3646-40FD-A2B8-9B574A6E6C32", secretsCount: "0"))
                items.append(DeviceModel(name: "iPhone 13 Pro", deviceType: .iphone, deviceId: "432F1298-4445-40DE-A4K8-8R577SPE6L82", secretsCount: "0"))
            } else {
                items.append(DeviceModel(name: "iPhoneSE", deviceType: .iphone, deviceId: "232F3207-3646-40FD-A2B8-9B574A6E6C32", secretsCount: "0"))
                items.append(DeviceModel(name: "iPhone 13 Pro", deviceType: .iphone, deviceId: "432F1298-4445-40DE-A4K8-8R577SPE6L82", secretsCount: "0"))
                items.append(DeviceModel(name: "Galaxy A04", deviceType: .phone, deviceId: "88533DD02-9321-JK09-SDH5-654HDBN86L33", secretsCount: "1"))
            }
            return items
        case .secrets:
//            let defaults = UserDefaults.standard
//            let descriptions = (defaults.array(forKey: "descriptions") as? [String]) ?? [String]()
//            for description in descriptions {
//                let secret = defaults.string(forKey: description) ?? ""
//                
//                let randomInt = Int.random(in: 0..<3)
//                let type = StrenghtType(rawValue: randomInt) ?? .weak
//                secrets.append(SecretModel(description: description, secret: secret, strenghtType: type))
//            }
            let iOSNumber = UserDefaults.standard.value(forKey: "iOSNumber") as! Int
            let secretCount = UserDefaults.standard.value(forKey: "secretCount") as! Int
            if secretCount == 1 {
                return [SecretModel(description: "Bitcoin wallet", secret: "1234567890", strenghtType: .strong)]
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

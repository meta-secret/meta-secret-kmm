//
//  ContentManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

protocol ContentManagerProtocol {
    func getContentItems(by type: ItemType) -> [any CommonItemModel]
}

class ContentManager: ContentManagerProtocol {
    func getContentItems(by type: ItemType) -> [any CommonItemModel] {
        #warning("Need to implement Device Manager and Secrets Manager")
        
        switch type {
        case .device:
            return [DeviceModel(name: "iPhone Dmitry", deviceType: .iphone, deviceId: "sdfds3423-sdfdsf324234-sdrfdf333-sdfsf33", secretsCount: "10")]
        case .secrets:
            return [SecretModel(description: "MetaMask wallet", strenghtType: .strong),
                    SecretModel(description: "Porn hub", strenghtType: .weak),
                    SecretModel(description: "Okx market", strenghtType: .maximum),
                    SecretModel(description: "Bybit", strenghtType: .strong),
                    SecretModel(description: "Binance", strenghtType: .maximum),
                    SecretModel(description: "Gosuslugi", strenghtType: .strong)]
        }
    }
}

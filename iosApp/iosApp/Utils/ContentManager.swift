//
//  ContentManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

protocol ContentManagerProtocol {
    func getContentItems(by type: ItemType) -> [CommonItemModel]
}

class ContentManager: ContentManagerProtocol {
    func getContentItems(by type: ItemType) -> [CommonItemModel] {
        #warning("Need to implement Device Manager and Secrets Manager")
        
        switch type {
        case .device:
            return [DeviceModel(name: "iPhone Dmitry")]
        case .secrets:
            return [SecretModel(description: "MetaMask wallet", strenghtType: .strong)]
        }
    }
}

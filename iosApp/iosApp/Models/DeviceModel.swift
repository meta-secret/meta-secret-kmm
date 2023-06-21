//
//  DeviceModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class DeviceModel: CommonItemModel {
    var type: ItemType
    private(set) var name: String
    private(set) var deviceType: DeviceType
    private(set) var deviceId: String
    private(set) var secretsCount: String
    
    init(name: String, deviceType: DeviceType, deviceId: String, secretsCount: String) {
        self.type = .device
        self.name = name
        self.deviceType = deviceType
        self.deviceId = deviceId
        self.secretsCount = secretsCount
    }
}

enum DeviceType {
    case phone
    case iphone
    case pad
    case noteBook
    
    var image: String {
        switch self {
        case .phone:
            return AppImages.Devices.phoneIco
        case .iphone:
            return AppImages.Devices.iphoneIco
        case .pad:
            return AppImages.Devices.padIco
        case .noteBook:
            return AppImages.Devices.noteBookIco
        }
    }
}

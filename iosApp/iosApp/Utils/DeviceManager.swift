//
//  DeviceManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 27.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

protocol DeviceManagerProtocol {
    func getDevicesCount() -> Int
}

class DeviceManager: DeviceManagerProtocol {
    func getDevicesCount() -> Int {
        #warning("Need to implement Device Manager and Secrets Manager")
        return 1
    }
}

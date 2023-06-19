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
    
    init(name: String) {
        self.type = .device
        self.name = name
    }
}

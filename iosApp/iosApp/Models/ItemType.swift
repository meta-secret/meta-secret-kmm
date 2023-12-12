//
//  ItemType.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

enum ItemType {
    case device
    case secrets
    
    func name() -> String {
        switch self {
        case .device:
            return "device"
        case .secrets:
            return "secrets"
        }
    }
}

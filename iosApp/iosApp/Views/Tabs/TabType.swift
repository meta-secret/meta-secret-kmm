//
//  TabType.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

enum TabType: Int, CaseIterable {
    case secrets = 0
    case devices
    case plus
    case help
    case profile
    
    var tabItem: TabItemData {
        switch self {
        case .secrets:
            return TabItemData(image: AppImages.secretsLogo, selectedImage: AppImages.secretsLogo, title: Constants.Main.secrets)
        case .devices:
            return TabItemData(image: AppImages.devicesLogo, selectedImage: AppImages.devicesLogo, title: Constants.Main.devices)
        case .plus:
            return TabItemData(image: "", selectedImage: "", title: "")
        case .help:
            return TabItemData(image: AppImages.helpLogo, selectedImage: AppImages.helpLogo, title: Constants.Main.help)
        case .profile:
            return TabItemData(image: AppImages.profileLogo, selectedImage: AppImages.profileLogo, title: Constants.Main.profile)
        }
    }
}

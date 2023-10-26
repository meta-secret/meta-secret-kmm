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
    case profile
    
    var tabItem: TabItemData {
        switch self {
        case .secrets:
            return TabItemData(image: AppImages.Main.secretsLogo, selectedImage: AppImages.Main.secretsLogo, title: Constants.Main.secrets)
        case .devices:
            return TabItemData(image: AppImages.Common.devicesIco, selectedImage: AppImages.Common.devicesIco, title: Constants.Main.devices)
        case .profile:
            return TabItemData(image: AppImages.Main.profileLogo, selectedImage: AppImages.Main.profileLogo, title: Constants.Main.profile)
        }
    }
}

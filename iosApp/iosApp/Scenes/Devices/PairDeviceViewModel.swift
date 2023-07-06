//
//  PairDeviceViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 06.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class PairDeviceViewModel: ObservableObject {
    let content: [PairPageView] = [
        PairPageView(pageType: .first),
        PairPageView(pageType: .second),
        PairPageView(pageType: .third)
    ]
    
    var pageType: PageType
    
    var totalSteps: Int {
        return PageType.allCases.count
    }
    
    init(pageType: PageType) {
        self.pageType = pageType
    }
}

extension PairDeviceViewModel {
    enum PageType: Int, CaseIterable {
        case first = 1
        case second
        case third
        
        var title: String? {
            switch self {
            case .first:
                return Constants.Devices.downloadApp
            case .second:
                return Constants.Devices.repeatNickName
            case .third:
                return Constants.Devices.approveConnection
            }
        }
        
        var imageName: String? {
            switch self {
            case .first:
                return ""//AppImages.stepOneIcon
            case .second:
                return ""//AppImages.stepTwoIcon
            case .third:
                return ""//AppImages.stepThreeIcon
            }
        }
    }
}

//
//  OnboardingContnetViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 20.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class OnboardingContnetViewModel {
    private(set) var pageType: PageType
    
    init(pageType: PageType) {
        self.pageType = pageType
    }
}

extension OnboardingContnetViewModel {
    enum PageType {
        case welcome
        case register
        case welcomeDB
        case welcomeQR
        case addSecret
        
        var title: String {
            switch self {
            case .welcome:
                return Constants.Splash.metaSecret
            case .register:
                return Constants.Onboarding.chooseName
            case .welcomeDB:
                return Constants.Onboarding.singleCopy
            case .welcomeQR:
                return Constants.Onboarding.addDevice
            case .addSecret:
                return Constants.Onboarding.addSecret
            }
        }
        
        var subtitle: String {
            switch self {
            case .welcome:
                return ""
            case .register:
                return Constants.Onboarding.step1
            case .welcomeDB:
                return Constants.Onboarding.step2
            case .welcomeQR:
                return Constants.Onboarding.step3
            case .addSecret:
                return Constants.Onboarding.step4
            }
        }
        
        var description: String {
            switch self {
            case .welcome:
                return Constants.Onboarding.whatIs
            case .register:
                return Constants.Onboarding.startToUse
            case .welcomeDB:
                return Constants.Onboarding.singleCopyText
            case .welcomeQR:
                return Constants.Onboarding.addDeviceText
            case .addSecret:
                return Constants.Onboarding.addSecretText
            }
        }
        
        var imageName: String {
            switch self {
            case .welcome:
                return AppImages.stepOneIcon
            case .register:
                return AppImages.stepTwoIcon
            case .welcomeDB:
                return AppImages.stepThreeIcon
            case .welcomeQR:
                return ""
            case .addSecret:
                return AppImages.stepFourIcon
            }
        }
        
        var placeHolder: String {
            switch self {
            case .welcome, .welcomeDB, .welcomeQR, .addSecret:
                return ""
            case .register:
                return Constants.Onboarding.vaultName
            }
        }
        
        var buttonTitle: String {
            return Constants.Onboarding.next
        }
        
        var backButtonTitle: String {
            return Constants.Onboarding.back
        }
    }
}

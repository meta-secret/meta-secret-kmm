//
//  OnboardingContnetViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 20.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class OnboardingContnetViewModel: ObservableObject {
    @Published var vaultName = ""
    
    var pageType: PageType
    private(set) var pageControllerViewModel: PageControllViewModel
    
    var skipText: String {
        return Constants.Common.skip
    }
    
    var nextText: String {
        return Constants.Common.next
    }
    
    init(pageType: PageType) {
        self.pageControllerViewModel = PageControllViewModel(pages: pageType.totalSteps)
        self.pageType = pageType
    }
}

extension OnboardingContnetViewModel {
    enum PageType: CaseIterable {
        case first
        case second
        case third
        case fourth
        
        var totalSteps: Int {
            return PageType.allCases.count
        }
        
        var title: String {
            switch self {
            case .first:
                return Constants.Onboarding.gotSecrets
            case .second:
                return Constants.Onboarding.gotSecrets
            case .third:
                return Constants.Onboarding.gotSecrets
            case .fourth:
                return Constants.Onboarding.gotSecrets
            }
        }
        
        var subtitle: String {
            switch self {
            case .first:
                return Constants.Onboarding.splitIt
            case .second:
                return ""
            case .third:
                return Constants.Onboarding.splitIt
            case .fourth:
                return ""
            }
        }
        
        var description: String {
            switch self {
            case .first:
                return Constants.Onboarding.secureSafe
            case .second:
                return Constants.Onboarding.secureSafe
            case .third:
                return Constants.Onboarding.secureSafe
            case .fourth:
                return Constants.Onboarding.secureSafe
            }
        }
        
        var imageName: String {
            switch self {
            case .first:
                return ""//AppImages.stepOneIcon
            case .second:
                return ""//AppImages.stepTwoIcon
            case .third:
                return ""//AppImages.stepThreeIcon
            case .fourth:
                return ""
            }
        }
        
        var currentPage: Int {
            switch self {
            case .first:
                return 1
            case .second:
                return 2
            case .third:
                return 3
            case .fourth:
                return 4
            }
        }
        
        var buttonTitle: String {
            return Constants.Common.next
        }
        
        var skipButtonTitle: String {
            return Constants.Common.skip
        }
    }
}

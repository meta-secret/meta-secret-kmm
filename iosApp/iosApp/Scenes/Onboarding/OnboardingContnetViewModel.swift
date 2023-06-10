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
    
    let content: [OnboardingPageView] = [
        OnboardingPageView(pageType: .first),
        OnboardingPageView(pageType: .second),
        OnboardingPageView(pageType: .third),
        OnboardingPageView(pageType: .fourth)
    ]
    
    var pageType: PageType
    var totalSteps: Int {
        return PageType.allCases.count
    }
    
    var skipText: String {
        return Constants.Common.skip
    }
    
    var nextText: String {
        return Constants.Common.next
    }
    
    init(pageType: PageType) {
        self.pageType = pageType
    }
}

extension OnboardingContnetViewModel {
    enum PageType: Int, CaseIterable {
        case first = 1
        case second
        case third
        case fourth
        
        var title: String? {
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
        
        var subtitle: String? {
            switch self {
            case .first:
                return Constants.Onboarding.splitIt
            case .second:
                return nil
            case .third:
                return Constants.Onboarding.splitIt
            case .fourth:
                return nil
            }
        }
        
        var description: String? {
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
        
        var imageName: String? {
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
        
        var buttonTitle: String {
            return Constants.Common.next
        }
        
        var skipButtonTitle: String {
            return Constants.Common.skip
        }
    }
}

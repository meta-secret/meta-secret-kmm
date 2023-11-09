//
//  OnboardingContnetViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 20.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class OnboardingContnetViewModel: ObservableObject {
    @Service private var authManager: AuthManagerProtocol
    @Published var vaultName = ""
    @Published var skipNext: Bool = false
    
    let content: [OnboardingPageView] = [
        OnboardingPageView(pageType: .first),
        OnboardingPageView(pageType: .second),
        OnboardingPageView(pageType: .third)
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
    
    func saveOnBoardingState() {
        return authManager.setOnboardingState()
    }
}

extension OnboardingContnetViewModel {
    enum PageType: Int, CaseIterable {
        case first = 1
        case second
        case third
        
        var title: String? {
            switch self {
            case .first:
                return Constants.Onboarding.gotSecrets
            case .second:
                return Constants.Onboarding.gotSecrets
            case .third:
                return Constants.Onboarding.gotSecrets
            }
        }
        
        var subtitle: String? {
            switch self {
            case .first:
                return Constants.Onboarding.splitIt
            case .second:
                return Constants.Onboarding.splitIt
            case .third:
                return Constants.Onboarding.splitIt
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
            }
        }
        
        var imageName: String? {
            switch self {
            case .first:
                return AppImages.Secrets.executioner
            case .second:
                return AppImages.Secrets.executioner
            case .third:
                return AppImages.Secrets.executioner
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

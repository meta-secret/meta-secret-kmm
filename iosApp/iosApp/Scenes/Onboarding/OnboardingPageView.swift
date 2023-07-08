//
//  OnboardingPageView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 10.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct OnboardingPageView: View, Hashable {
    let pageType: OnboardingContnetViewModel.PageType
    
    private enum Config {
        static let sideOffset: CGFloat = 16.0
    }
    
    var body: some View {
        VStack {
            if let image = pageType.imageName {
                Spacer()
            }
            
            if let title = pageType.title {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(FontStyle.chapter.font)
                    .foregroundColor(AppColors.white)
                Spacer().frame(height: Config.sideOffset)
            }
            
            if let subtitle = pageType.subtitle {
                Text(subtitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(FontStyle.h2.font)
                    .foregroundColor(AppColors.white)
                Spacer().frame(height: Config.sideOffset)
            }
            
            if let description = pageType.description {
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(FontStyle.normalMain.font)
                    .foregroundColor(AppColors.white75)
            }
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            OnboardingPageView(pageType: .second)
        }
    }
}

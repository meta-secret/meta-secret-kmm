//
//  SplashView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
//import shared

struct SplashView: View {
    @State var navigateToNextScreen: Bool = false
    @State var overviewShowen: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.mainBg).ignoresSafeArea()
                ZStack {
                    Image(AppImages.splashGradient)
                        .padding(.bottom, 63)
                    VStack {
                        Image(AppImages.splashLogo)
                        Image(AppImages.metaTitle)
                            .padding(.top, 40)
                    }
                }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.navigateToNextScreen = true
                    }
                }
            }
            .background(
                NavigationLink(
                    destination: WelcomeView(viewModel: OnboardingContnetViewModel(pageType: .first))
                    .navigationBarBackButtonHidden(true),
                    isActive: $navigateToNextScreen,
                    label: { EmptyView() }
                )
            )
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

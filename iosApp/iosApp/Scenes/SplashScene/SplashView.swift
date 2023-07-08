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
    private enum Config {
        static let imageBottomPadding: CGFloat = 63.0
        static let titleTopPadding: CGFloat = 40.0
        static let delay: CGFloat = 2.0
    }
    
    @State var viewModel: SplashViewModel
    @State var navigateToOnboarding: Bool = false
    @State var navigateToMain: Bool = false
    @State var overviewShowen: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.Common.mainBg)
                    .resizable()
                    .ignoresSafeArea()
                ZStack {
                    Image(AppImages.Splash.splashGradient)
                        .padding(.bottom, Config.imageBottomPadding)
                    VStack {
                        Image(AppImages.Splash.splashLogo)
                        Image(AppImages.Splash.metaTitle)
                            .padding(.top, Config.titleTopPadding)
                    }
                }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + Config.delay) {
                    withAnimation {
                        if viewModel.checkAuth() {
                            navigateToMain = true
                        } else {
                            navigateToOnboarding = true
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToMain) {
                MainSceneView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $navigateToOnboarding) {
                OnboardingContainerView(viewModel: OnboardingContnetViewModel(pageType: .first))
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
    }
}

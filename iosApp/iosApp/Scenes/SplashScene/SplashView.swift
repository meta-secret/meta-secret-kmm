//
//  SplashView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct SplashView: View {
    private enum Config {
        static let imageBottomPadding: CGFloat = 63.0
        static let titleTopPadding: CGFloat = 40.0
        static let delay: CGFloat = 2.0
    }
    
    @StateObject var viewModel: SplashViewModel
    
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
                viewModel.checkBiometric { (success) in
                    withAnimation {
                        if let _ = viewModel.errorBiometric {
                            viewModel.needAlert = true
                        } else {
                            if viewModel.readOnboardingKey() {
                                if viewModel.checkAuth() == .alreadyRegistered {
                                    viewModel.navigateToMain = true
                                } else {
                                    viewModel.navigateToSignIn = true
                                }
                            } else {
                                viewModel.navigateToOnboarding = true
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $viewModel.needAlert, content: {
                Alert(
                    title: Text(Constants.Errors.error),
                    message: Text(viewModel.errorBiometric?.errorDescription ?? ""),
                    primaryButton: .default(Text(Constants.Alert.ok), action: {
                        if viewModel.errorBiometric == BiometricError.userCancel {
                            viewModel.needAlert = false
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }
                    }),
                    secondaryButton: .cancel(Text(Constants.Alert.cancel))
                )
            })
            .navigationDestination(isPresented: $viewModel.navigateToMain) {
                MainSceneView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $viewModel.navigateToSignIn) {
                SignInView(viewModel: SignInViewModel())
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $viewModel.navigateToOnboarding) {
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

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
    @State var navigateToNextScreen: Bool = false
    
    private enum Config {
        static let mainBgOpacity = 0.1
    }

    var body: some View {
        NavigationView {
            ZStack {
                AppColors.mainYellow.ignoresSafeArea()
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: AppColors.mainBlack))
                    Text(Constants.Splash.metaSecret)
                        .foregroundColor(AppColors.mainBlack)
                        .font(.custom(Avenir.heavy.rawValue, size: AvenirSize.h1.rawValue))
                }
                Image(AppImages.mainBg)
                    .opacity(Config.mainBgOpacity)
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
                    destination: WelcomeView(viewModel: OnboardingContnetViewModel(pageType: .welcome))
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

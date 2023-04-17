//
//  WelcomeDBView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.04.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct WelcomeDBView: View {
    @StateObject var viewModel: OnboardingContnetViewModel
    @State private var isPushed = false
    
    private enum Config {
        static let verticalSpacing: CGFloat = 14.0
        static let cornerRadius: CGFloat = 10.0
        static let sideOffset: CGFloat = 16.0
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    // Subtitle
                    Spacer()
                        .frame(height: Config.verticalSpacing * 2)
                    HStack {
                        Text(viewModel.pageType.subtitle)
                            .font(.custom(Avenir.medium.rawValue, size: AvenirSize.t2.rawValue))
                            .foregroundColor(AppColors.mainDarkGray)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Main title
                    HStack {
                        Text(viewModel.pageType.title)
                            .font(.custom(Avenir.heavy.rawValue, size: AvenirSize.h3.rawValue))
                            .foregroundColor(AppColors.mainBlack)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Image
                    Image(viewModel.pageType.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom)
                        .frame(height: 200)
                    
                    // Description
                    Text(viewModel.pageType.description)
                        .font(.custom(Avenir.medium.rawValue, size: AvenirSize.t2.rawValue))
                        .foregroundColor(AppColors.mainBlack)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                    
                    // Buttons
                    NavigationLink(destination: WelcomeQRView(viewModel: viewModel), isActive: $isPushed, label: {
                        Text(viewModel.pageType.buttonTitle)
                            .frame(width: geo.size.width - Config.sideOffset * 2, height: 48)
                            .font(.custom(Avenir.bold.rawValue, size: AvenirSize.t2.rawValue))
                            .foregroundColor(AppColors.mainBlack)
                            .background(AppColors.mainOrange)
                            .cornerRadius(Config.cornerRadius)
                        
                    })
                    .onChange(of: isPushed, perform: { _ in
                        viewModel.pageType = .welcomeQR
                    })
                    Spacer()
                        .frame(height: Config.verticalSpacing)
                }
            }
            .background(AppColors.mainCreame).ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct WelcomeDBView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeDBView(viewModel: OnboardingContnetViewModel(pageType: .welcomeDB))
    }
}

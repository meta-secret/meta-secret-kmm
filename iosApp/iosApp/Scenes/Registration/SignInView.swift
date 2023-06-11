//
//  SignInView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 11.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    private enum Config {
        static let sideOffset: CGFloat = 16.0
        static let spacerHeight: CGFloat = 14.0
    }
    
    let viewModel = SignInViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.mainBg)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image(AppImages.signInLogo)
                        .padding(.top, -54)
                        
                    Text(viewModel.titleText)
                        .font(FontStyle.h1.font)
                        .foregroundColor(AppColors.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer().frame()
                    Spacer()
                }
                .padding(.horizontal, Config.sideOffset)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

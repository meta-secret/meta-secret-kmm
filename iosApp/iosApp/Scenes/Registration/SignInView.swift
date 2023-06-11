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
        static let cornerRadius: CGFloat = 8.0
    }
    
    @State private var nickName = ""
    
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
                    
                    Spacer().frame(height: Config.spacerHeight)
                    Text(viewModel.descriptionText)
                        .font(FontStyle.normalMain.font)
                        .foregroundColor(AppColors.white75)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer().frame(height: Config.spacerHeight * 2)
                    Button(action: {
                        
                    }) {
                        Text(viewModel.scanQrText)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 48)
                            .foregroundColor(AppColors.white)
                            .font(FontStyle.button.font)
                            .cornerRadius(Config.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: Config.cornerRadius)
                                    .stroke(AppColors.white50, lineWidth: 1)
                            )
                    }
                    .frame(height: 48)
                    
                    VStack {
                        Spacer().frame(height: Config.spacerHeight)
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: Config.cornerRadius)
                                .fill(AppColors.white5)
                                .frame(width: .infinity, height: 52.0)
                            Text(nickName == "" ? viewModel.placeholder : "")
                                .font(FontStyle.normal.font)
                                .foregroundColor(AppColors.white40)
                                .padding(.horizontal)
                            TextField("", text: $nickName)
                                .textFieldStyle(.plain)
                                .padding(.horizontal)
                                .foregroundColor(AppColors.white)
                                .font(FontStyle.normalInput.font)
                                .textFieldStyle(.roundedBorder)
                            
                        }
                        .frame(height: 52.0)
                        
                        Spacer().frame(height: Config.spacerHeight * 2.5)
                        NextButtonView(title: viewModel.nextButtonText)
                        Spacer()
                    }
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

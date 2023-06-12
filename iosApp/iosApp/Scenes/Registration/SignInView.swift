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
        static let buttonHeight: CGFloat = 48.0
        static let textfieldHeight: CGFloat = 52.0
    }
    
    let viewModel = SignInViewModel()
    
    @State private var nickName: String
    @State var signInError: String
    @State var isError = false
    
    init() {
        self.nickName = ""
        self.signInError = "Данный никнейм уже занят. Попробуйте другой"
    }
    
    
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
                            .frame(height: Config.buttonHeight)
                            .foregroundColor(AppColors.white)
                            .font(FontStyle.button.font)
                            .cornerRadius(Config.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: Config.cornerRadius)
                                    .stroke(AppColors.white50, lineWidth: 1)
                            )
                    }
                    .frame(height: Config.buttonHeight)
                    
                    VStack {
                        Spacer().frame(height: Config.spacerHeight)
                        TipTextfieldView(placeHolder: viewModel.placeholder, error: isError ? $signInError : .constant(""))
                        
                        Spacer().frame(height: Config.spacerHeight)
                        ActionBlueButton(title: viewModel.nextButtonText, action: {
                            isError = !isError
                        })
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

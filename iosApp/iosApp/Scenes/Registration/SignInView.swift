//
//  SignInView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 11.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import Combine

struct SignInView: View {
    private enum Config {
        static let sideOffset: CGFloat = 16.0
        static let spacerHeight: CGFloat = 14.0
        static let cornerRadius: CGFloat = 8.0
        static let buttonHeight: CGFloat = 48.0
        static let textfieldHeight: CGFloat = 52.0
        static let imageTopOffset: CGFloat = 54.0
    }
    
    @StateObject var viewModel: SignInViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Bg
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.Common.mainBg)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    //Logo
                    Image(AppImages.SignIn.signInLogo)
                        .padding(.top, -Config.imageTopOffset)
                       
                    //Title
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

                    //ScanQR button
                    Button(action: {
                        viewModel.isLoading.toggle()
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
                    .navigationDestination(isPresented: $viewModel.isQrCodeScanner) {
                        // Need implementation
                    }

                    VStack {
                        // Name text field
                        Spacer().frame(height: Config.spacerHeight)
                        TipTextfieldView(textValue: $viewModel.nickName, placeHolder: viewModel.placeholder, error: viewModel.isError ? $viewModel.signInError : .constant(nil), isRequired: true)

                        // Next button
                        Spacer().frame(height: Config.spacerHeight)
                        ActionBlueButton(title: viewModel.nextButtonText, action: {
                            if viewModel.nickName == nil || viewModel.nickName!.isEmpty {
                                viewModel.signInError = Constants.Errors.requiredField
                                viewModel.isError = true
                            } else {
                                viewModel.checkAndSaveName(name: viewModel.nickName ?? "")
                            }
                        })
                        Spacer()
                    }
                }
                .padding(.horizontal, Config.sideOffset)
                .keyboardAdaptive()
                
                LoaderWithDimmingView(isLoading: $viewModel.isLoading)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}

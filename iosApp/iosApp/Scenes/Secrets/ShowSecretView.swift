//
//  ShowSecretView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import Combine

struct ShowSecretView: View {
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let sideOffset: CGFloat = 16.0
        static let closeSideOffset: CGFloat = 10.0
        static let vSpacerHeight: CGFloat = 24.0
        static let bottomSpacerHeight: CGFloat = 30.0
        static let fieldHeight: CGFloat = 48.0
        static let smallCornerRadius: CGFloat = 8.0
        static let animationDuration: CGFloat = 0.3
    }
    
    @State var saveError: String? = Constants.Common.enterValue
    @State var isPasswordHidden: Bool = true
    @Binding var showPopUp: Bool
    
    var secretName: String
    var secret: String
    
    var body: some View {
        VStack {
            Spacer().frame(maxHeight: .infinity)
            ZStack {
                RoundedRectangle(cornerRadius: Config.cornerRadius)
                    .fill(AppColors.blackPopUps)
                    .frame(maxWidth: .infinity)
                
                VStack {
                    //Close button
                    VStack {
                        Spacer()
                            .frame(height: Config.closeSideOffset)
                        HStack {
                            Spacer()
                            CloseButtonView(action: {
                                withAnimation(.linear(duration: Config.animationDuration)) {
                                    showPopUp = false
                                }
                            })
                            Spacer()
                                .frame(width: Config.closeSideOffset)
                        }
                    }
                    
                    //Title
                    VStack {
                        HStack {
                            Spacer()
                            Text(Constants.Secrets.showSecret)
                                .font(FontStyle.h1.font)
                                .foregroundColor(AppColors.white)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: Config.vSpacerHeight)
                    }
                    
                    //Secret name container
                    VStack {
                        ZStack {
                            //Secret name container bg
                            RoundedRectangle(cornerRadius: Config.smallCornerRadius)
                                .fill(AppColors.blackBg50)
                                .frame(maxWidth: .infinity)
                                .frame(height: Config.fieldHeight)
                                .padding(.horizontal, Config.sideOffset)
                            
                            Text(secretName)
                                .foregroundColor(Color.white)
                                .font(FontStyle.normalSemi.font)
                        }
                        Spacer().frame(height: Config.vSpacerHeight / 2)
                    }
                    
                    //Secret container
                    VStack {
                        ZStack {
                            //Secret container bg
                            RoundedRectangle(cornerRadius: Config.smallCornerRadius)
                                .fill(AppColors.blackBg50)
                                .frame(maxWidth: .infinity)
                                .frame(height: Config.fieldHeight)
                                .padding(.horizontal, Config.sideOffset)
                            
                            Text(getSecret())
                                .foregroundColor(Color.white)
                                .font(FontStyle.normalSemi.font)
                        }
                        Spacer().frame(height: Config.sideOffset)
                    }
                    
                    // Device counter
                    VStack {
                        HStack {
                            Image(AppImages.Common.devicesIco)
                            Text(Constants.Secrets.devicesCount)
                                .font(FontStyle.normal.font)
                                .foregroundColor(AppColors.white75)
                        }
                        Spacer().frame(height: Config.sideOffset)
                    }
                    
                    VStack {
                        ActionBlueButton(title: getButtonTitle()) {
                            isPasswordHidden.toggle()
                        }
                        Spacer().frame(height: Config.bottomSpacerHeight)
                    }
                    .padding(Config.sideOffset)
                    
                    Spacer()
                }
                
            }
            Spacer().frame(maxHeight: .infinity)
        }
        .padding(.horizontal, Config.sideOffset)
    }
    
    func getSecret() -> String {
        if isPasswordHidden {
            return String(repeating: "*", count: secret.count)
        } else {
            return secret
        }
    }
    
    func getButtonTitle() -> String {
        if isPasswordHidden {
            return Constants.Secrets.show
        } else {
            return Constants.Secrets.copySecret
        }
    }
}


struct ShowSecretView_Previews: PreviewProvider {
    static var previews: some View {
        ShowSecretView(showPopUp: .constant(true), secretName: "Secret name", secret: "Secret")
    }
}

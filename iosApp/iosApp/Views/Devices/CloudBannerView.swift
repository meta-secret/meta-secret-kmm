//
//  CloudBannerView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 06.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct CloudBannerView: View {
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let smallCornerRadius: CGFloat = 8.0
        static let height: CGFloat = 268
        static let soonSize: CGSize = CGSize(width: 57.0, height: 30.0)
        static let bigSideOffset: CGFloat = 26.0
        static let topOffset: CGFloat = 10.0
        static let commonOffset: CGFloat = 16.0
        static let spacer: CGFloat = 56.0
    }
    
    var body: some View {
        ZStack {
            // Bg rounded
            Rectangle()
                .fill(AppColors.white5)
                .frame(height: Config.height)
                .cornerRadius(Config.cornerRadius, corners: [.allCorners])
                .ignoresSafeArea()
            
            VStack {
                // Soon container
                VStack {
                    Spacer().frame(height: Config.topOffset)
                    HStack {
                        Spacer()
                        ZStack {
                            // Soon bg
                            Rectangle()
                                .fill(AppColors.blackLabel)
                                .frame(width: Config.soonSize.width, height: Config.soonSize.height)
                                .cornerRadius(Config.smallCornerRadius, corners: [.allCorners])
                                .ignoresSafeArea()
                            // Soon text
                            Text(Constants.Devices.soon)
                                .font(FontStyle.normalSmall.font)
                                .foregroundColor(AppColors.white75)
                        }
                        Spacer().frame(width: Config.topOffset)
                    }
                }
                
                Spacer().frame(height: Config.commonOffset)
                
                // Logo
                HStack {
                    Spacer().frame(width: Config.commonOffset * 2)
                    Image(AppImages.Devices.cloudLogo)
                    Image(AppImages.Devices.cloudTitleLogo)
                        .padding(.leading, Config.commonOffset)
                        .padding(.top, Config.topOffset)
                    Spacer()
                }
                
                Spacer().frame(height: Config.spacer)
                
                // Title
                HStack {
                    Spacer().frame(width: Config.commonOffset)
                    Text(Constants.Devices.notEnoughtDevices)
                        .font(FontStyle.h2.font)
                        .foregroundColor(AppColors.white)
                    Spacer()
                }
                
                Spacer().frame(height: Config.topOffset)
                
                // Text
                HStack {
                    Spacer().frame(width: Config.commonOffset)
                    Text(Constants.Devices.metaSecretCloud)
                        .foregroundColor(AppColors.white75)
                        .font(FontStyle.normalMain.font)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                Spacer()
            }
            .frame(height: Config.height)
        }
    }
}

struct CloudBannerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            CloudBannerView()
        }
        
    }
}

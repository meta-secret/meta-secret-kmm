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
        static let height: CGFloat = 268
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(AppColors.white5)
                .frame(height: Config.height)
                .cornerRadius(Config.cornerRadius, corners: [.allCorners])
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(AppColors.blackLabel)
                            .frame(width: 57.0, height: 30.0)
                            .cornerRadius(8.0, corners: [.allCorners])
                            .ignoresSafeArea()
                        Text(Constants.Devices.soon)
                            .font(FontStyle.normalSmall.font)
                            .foregroundColor(AppColors.white75)
                    }
                    .padding(.trailing, 26.0)
                    .padding(.top, 10)
                }
                Spacer()
                    .frame(height: 15.0)
                
                HStack {
                    Spacer()
                        .frame(width: 32.0)
                    Image(AppImages.Devices.cloudLogo)
                    Image(AppImages.Devices.cloudTitleLogo)
                        .padding(.leading, 16.0)
                        .padding(.top, 10)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 56.0)
                HStack {
                    Spacer()
                        .frame(width: 16.0)
                    Text(Constants.Devices.notEnoughtDevices)
                        .font(FontStyle.h2.font)
                        .foregroundColor(AppColors.white)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 12.0)
                HStack {
                    Spacer()
                        .frame(width: 16.0)
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

//
//  DevicesCellView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 20.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct DevicesCellView: View {
    private var item: DeviceModel
    
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let height: CGFloat = 96.0
    }
    
    init(item: DeviceModel) {
        self.item = item
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Config.cornerRadius)
                .fill(AppColors.white5)
                .frame(maxWidth: .infinity)
                .frame(height: Config.height)
            HStack {
                Image(item.deviceType.image)
                Spacer()
                    .frame(width: 10.0)
                VStack {
                    HStack {
                        Text(item.name)
                            .font(FontStyle.h4.font)
                            .foregroundColor(AppColors.white)
                        Spacer()
                    }
                    HStack {
                        Text(item.deviceId)
                            .font(FontStyle.mini.font)
                            .foregroundColor(AppColors.white30)
                        Spacer()
                    }
                    HStack {
                        Text(Constants.Secrets.secretsCount(item.secretsCount))
                            .font(FontStyle.normal.font)
                            .foregroundColor(AppColors.white75)
                        Spacer()
                    }
                    
                }
                
                Spacer()
                    .frame(width: 10.0)
                Image(AppImages.Common.chevroneRightIco)
            }
            .padding(.horizontal, 16.0)
        }
    }
}

struct DevicesCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            DevicesCellView(item: DeviceModel(name: "iPhone Dmitry", deviceType: .iphone, deviceId: "sdfds3423-sdfdsf324234-sdrfdf333-sdfsf33", secretsCount: 1))
        }
    }
}

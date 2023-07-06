//
//  AddDeviceView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 27.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct AddDeviceView: View {
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let height: CGFloat = 258
    }
    
    var body: some View {
        VStack {
            ZStack {
                AppColors.blackPopUps.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        CloseButtonView(action: {})
                    }
                    .padding(.horizontal, 10.0)
                    HStack {
                        Text(Constants.Devices.addDevice)
                            .font(FontStyle.h1.font)
                            .foregroundColor(AppColors.white)
                        Spacer()
                    }
                    .padding(.horizontal, 16.0)
                    Spacer().frame(height: 24)
                    
                    HStack {
                        Text(Constants.Devices.threeDevicesNeeded)
                            .font(FontStyle.normalMain.font)
                            .foregroundColor(AppColors.white75)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.horizontal, 16.0)
                    Spacer().frame(height: 24)
                    
                    CloudBannerView()
                        .padding(.horizontal, 16.0)
                    
                    HStack {
                        ActionBlueButton(title: "+ \(Constants.Devices.addDevice)", action: {})
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 16.0)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct AddDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        AddDeviceView()
    }
}

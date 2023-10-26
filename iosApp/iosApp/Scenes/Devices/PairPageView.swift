//
//  PairPageView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 06.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct PairPageView: View, Hashable {
    let pageType: PairDeviceViewModel.PageType
    
    private enum Config {
        static let sideOffset: CGFloat = 16.0
        static let height: CGFloat = 180.0
        static let cornerRadius: CGFloat = 12.0
    }
    
    var body: some View {
        VStack {
            ZStack {
                AppColors.blackPopUps.ignoresSafeArea()
                Rectangle()
                    .fill(AppColors.white5)
                    .frame(height: Config.height)
                    .cornerRadius(Config.cornerRadius, corners: [.allCorners])
                    .ignoresSafeArea()
                if let image = pageType.imageName {
                    Image(image)
                }
            }
            .frame(height: Config.height)
            
            Spacer()
                .frame(height: 39.0)
            
            if let title = pageType.title {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(FontStyle.normalMain.font)
                    .foregroundColor(AppColors.white75)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 16.0)
    }
}

struct PairPageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            PairPageView(pageType: .first)
        }
    }
}

//
//  SecretCellView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 15.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SecretCellView: View {
    private var item: SecretModel
    
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let height: CGFloat = 96.0
    }
    
    init(item: SecretModel) {
        self.item = item
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Config.cornerRadius)
                .fill(AppColors.white5)
                .frame(maxWidth: .infinity)
                .frame(height: Config.height)
            
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(item.description)
                            .font(FontStyle.h3.font)
                            .foregroundColor(AppColors.white)
                    }
                    .frame(height: 22)
                    HStack {
                        Image(AppImages.Common.devicesIco)
                        Text(devicesText())
                            .font(FontStyle.normalMain.font)
                            .foregroundColor(AppColors.white75)
                    }
                    .frame(height: 20)
                }
                Spacer()
                VStack {
                    Image(item.strenghtType.image)
                    Text(item.strenghtType.title)
                        .font(FontStyle.mini.font)
                        .foregroundColor(AppColors.white75)
                }
                .frame(width: 56)
            }
            .padding(.horizontal, 16.0)
        }
    }
}

func devicesText() -> String {
    let devicesCount = UserDefaults.standard.value(forKey: "deviceCount") as! Int
    if devicesCount == 3 {
        return Constants.Secrets.devicesCount2
    } else {
        return Constants.Secrets.devicesCount
    }
}

struct SecretCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            SecretCellView(item: SecretModel(description: "MetaWallet", secret: "Secret!!!", strenghtType: .maximum))
        }
    }
}

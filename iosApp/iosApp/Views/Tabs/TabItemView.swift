//
//  TabItemView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct TabItemView: View {
    let data: TabItemData
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
            Spacer().frame(height: 4)
            
            Text(data.title)
                .font(FontStyle.mini.font)
                .foregroundColor(AppColors.white)
        }
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(data: TabItemData(image: AppImages.secretsLogo, selectedImage: AppImages.secretsLogo, title: Constants.Main.secrets), isSelected: false)
    }
}

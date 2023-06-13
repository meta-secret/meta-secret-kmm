//
//  TabBottomView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct TabBottomView: View {
    
    let tabbarItems: [TabItemData]
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(tabbarItems.indices) { index in
                    let item = tabbarItems[index]
                    Button {
                        self.selectedIndex = index
                    } label: {
                        TabItemView(data: item, isSelected: false)
                            .frame(width: (UIScreen.main.bounds.width - 40) / CGFloat(tabbarItems.count))
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 68.0)
            .background(AppColors.blackMenu)
            
            PlusButtonView(action: {})
                .padding(.top, -64.0)
        }
    }
}

struct TabBottomView_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [TabItemData] = [
            TabItemData(image: AppImages.secretsLogo, selectedImage: AppImages.secretsLogo, title: Constants.Main.secrets),
            TabItemData(image: AppImages.devicesLogo, selectedImage: AppImages.secretsLogo, title: Constants.Main.secrets),
            TabItemData(image: "", selectedImage: "", title: ""),
            TabItemData(image: AppImages.helpLogo, selectedImage: AppImages.secretsLogo, title: Constants.Main.secrets),
            TabItemData(image: AppImages.profileLogo, selectedImage: AppImages.secretsLogo, title: Constants.Main.secrets)
        ]
        TabBottomView(tabbarItems: tabs, selectedIndex: .constant(0))
    }
}

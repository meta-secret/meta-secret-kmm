//
//  TabBottomView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct TabBottomView: View {
    private enum Config {
        static let widthDelta: CGFloat = 48.0
        static let height: CGFloat = 72.0
    }
    
    @Binding var selectedIndex: Int
    
    let action: () -> Void
    let tabbarItems: [TabItemData]
    
    var body: some View {
            ZStack {
                HStack {
                    ForEach(tabbarItems.indices) { index in
                        let item = tabbarItems[index]
                        Button {
                            self.selectedIndex = index
                        } label: {
                            TabItemView(data: item, isSelected: false)
                                .frame(width: (UIScreen.main.bounds.width - Config.widthDelta) / CGFloat(tabbarItems.count))
                        }
                    }
                }
                .padding(.bottom, 6.0)
                .frame(width: UIScreen.main.bounds.width, height: Config.height)
                .background(AppColors.blackMenu)
                
                HStack {
                    Spacer()
                        .frame(width: (CGFloat(selectedIndex) * UIScreen.main.bounds.width / CGFloat(tabbarItems.count)))
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / CGFloat(tabbarItems.count)) + 7, height: 4)
                        .foregroundColor(AppColors.actionBlue)
                    Spacer()
                }
                .padding(.top, -Config.height/2)
                
                HStack {
                    Spacer()
                    PlusButtonView(action: action)
                        .padding(.top, -140.0)
                    Spacer().frame(width: 24.0)
                }
            }
            .animation(.linear, value: UUID())
    }
}

struct TabBottomView_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [TabItemData] = [
            TabItemData(image: AppImages.Main.secretsLogo, selectedImage: AppImages.Main.secretsLogo, title: Constants.Main.secrets),
            TabItemData(image: AppImages.Common.devicesIco, selectedImage: AppImages.Common.devicesIco, title: Constants.Main.secrets),
            TabItemData(image: AppImages.Main.profileLogo, selectedImage: AppImages.Main.profileLogo, title: Constants.Main.secrets)
        ]
        TabBottomView(selectedIndex: .constant(0), action: {}, tabbarItems: tabs)
    }
}

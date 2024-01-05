//
//  AlertBubbleView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct AlertBubbleView: View {
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let height: CGFloat = 96.0
        static let warningSize: CGSize = .init(width: 24.0, height: 24.0)
        static let spacer: CGFloat = 14.0
        static let sideOffset: CGFloat = 16.0
        static let smallSideOffset: CGFloat = 6.0
    }
    
    var body: some View {
        ZStack {
            //Bg
            RoundedRectangle(cornerRadius: Config.cornerRadius)
                .fill(AppColors.white5)
                .frame(maxWidth: .infinity)
                .frame(height: Config.height)
            
            //Main container
            HStack {
                //Left part
                VStack {
                    //Warning sign
                    Image(AppImages.Common.warningSign)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Config.warningSize.width, height: Config.warningSize.height)
                    Spacer()
                }
                Spacer()
                    .frame(width: Config.spacer)
                //Middle part
                VStack {
                    Text(message1 + message2)
                    Spacer()
                }
                Spacer()
                    .frame(width: Config.spacer)
                //Right part
                VStack {
                    CloseButtonView(action: {})
                    Spacer()
                }
                .padding(.top, -Config.spacer/2)
            }
            .padding(.init(top: Config.sideOffset, leading: Config.sideOffset, bottom: Config.sideOffset/2, trailing: Config.smallSideOffset))
            .frame(height: Config.height)
            .frame(maxWidth: .infinity)
        }
    }
}

private extension AlertBubbleView {
    var message1: AttributedString {
        var result = AttributedString(Constants.MainScreen.addDevices(memberCounts: 1))
        result.font = FontStyle.normalMain.font
        result.foregroundColor = AppColors.white75
        return result
    }
    
    var message2: AttributedString {
        var result = AttributedString(Constants.Common.addPLus)
        result.font = FontStyle.normalMain.font
        result.foregroundColor = AppColors.actionLinkBlue
        return result
    }

}

struct AlertBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            AlertBubbleView()
        }
        
    }
}

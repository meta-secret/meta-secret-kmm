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
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Config.cornerRadius)
                .fill(AppColors.white5)
                .frame(maxWidth: .infinity)
                .frame(height: Config.height)
            
            HStack {
                VStack {
                    Image(AppImages.Common.warningSign)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.0, height: 24.0)
                    Spacer()
                }
                Spacer()
                    .frame(width: 12.0)
                VStack {
                    Text(message1 + message2)
                    Spacer()
                }
                Spacer()
                    .frame(width: 12.0)
                VStack {
                    CloseButtonView(action: {})
                    Spacer()
                }
                .padding(.top, -6)
            }
            .padding(.init(top: 16.0, leading: 16.0, bottom: 16.0, trailing: 6.0))
            .frame(height: 96)
            .frame(maxWidth: .infinity)
        }
    }
}

private extension AlertBubbleView {
    var message1: AttributedString {
        var result = AttributedString(Constants.Common.needDevices)
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

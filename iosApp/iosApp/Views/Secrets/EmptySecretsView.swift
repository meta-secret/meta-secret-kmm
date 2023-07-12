//
//  EmptySecretsView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 14.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct EmptySecretsView: View {
    private enum Config {
        static let sideOffset: CGFloat = 44.0
        static let arrowHeight: CGFloat = 154.0
        static let arrowSideOffset: CGFloat = 128.0

    }
    
    var body: some View {
        VStack {
            // Image of a man
            Image(AppImages.Secrets.executioner)
            
            //Title
            Text(Constants.Secrets.noSecrets)
                .font(FontStyle.h1.font)
                .foregroundColor(AppColors.white)
            
            //Subtitle
            Text(Constants.Secrets.youHaveNoSecrets)
                .font(FontStyle.normalMain.font)
                .foregroundColor(AppColors.white75)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Config.sideOffset)
            
            //Image of the arrow
            Image(AppImages.Secrets.slashedArrow)
                .frame(height: Config.arrowHeight)
                .padding(.leading, Config.arrowSideOffset)
        }
    }
}

struct EmptySecretsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            EmptySecretsView()
        }
    }
}

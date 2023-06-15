//
//  EmptySecretsView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 14.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct EmptySecretsView: View {
    var body: some View {
        VStack {
            Image(AppImages.Secrets.executioner)
            Text(Constants.Secrets.noSecrets)
                .font(FontStyle.h1.font)
                .foregroundColor(AppColors.white)
            Text(Constants.Secrets.youHaveNoSecrets)
                .font(FontStyle.normalMain.font)
                .foregroundColor(AppColors.white75)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20.0)
            Image(AppImages.Secrets.slashedArrow)
                .frame(height: 154)
                .padding(.leading, 128)
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

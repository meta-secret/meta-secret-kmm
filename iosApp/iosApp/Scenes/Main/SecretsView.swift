//
//  SecretsView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SecretsView: View {
    var body: some View {
        ZStack {
            
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.mainBg)
                .resizable()
                .ignoresSafeArea()
            
            Text("Secrets")
                .foregroundColor(Color.white)
            
        }
    }
}

struct SecretsView_Previews: PreviewProvider {
    static var previews: some View {
        SecretsView()
    }
}

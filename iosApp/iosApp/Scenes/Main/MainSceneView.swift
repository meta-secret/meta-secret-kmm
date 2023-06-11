//
//  MainSceneView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MainSceneView: View {
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.mainBg)
                    .resizable()
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView()
    }
}

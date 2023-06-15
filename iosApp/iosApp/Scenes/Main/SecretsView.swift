//
//  SecretsView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SecretsView: View {
    @State var viewModel: SecretsViewModel = SecretsViewModel()
    
    var body: some View {
        ZStack {
            
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.mainBg)
                .resizable()
                .ignoresSafeArea()
            if viewModel.items.isEmpty {
                VStack {
                    EmptySecretsView()
                }
            } else {
                Text("Secrets")
                    .foregroundColor(Color.white)
            }
            
        }
        .border(.red)
    }
}

struct SecretsView_Previews: PreviewProvider {
    static var previews: some View {
        SecretsView()
    }
}

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
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            if viewModel.items.isEmpty {
                VStack {
                    Spacer()
                    EmptySecretsView()
                    Spacer()
                        .frame(height: 32)
                }
            } else {
                List {
                    ForEach(viewModel.items, id: \.id) { item in
                        SecretCellView(item: item as! SecretModel)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                .scrollContentBackground(.hidden)
                
            }
        }
    }
}

struct SecretsView_Previews: PreviewProvider {
    static var previews: some View {
        SecretsView()
    }
}

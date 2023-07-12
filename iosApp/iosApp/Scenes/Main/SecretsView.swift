//
//  SecretsView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SecretsView: View {
    private enum Config {
        static let sideOffset: CGFloat = 16.0
        static let bubbleSideOffset: CGFloat = 20.0
        static let vSpacerHeight: CGFloat = 30.0
        static let addSecretHeight: CGFloat = 344.0
        static let addDeviceHeight: CGFloat = 510.0
        static let bottomSpacer: CGFloat = 14.0
    }
    
    @State var viewModel: SecretsViewModel = SecretsViewModel()
    
    var body: some View {
        ZStack {
            //Bg
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            if viewModel.items.isEmpty {
                //Empty view
                VStack {
                    Spacer()
                    EmptySecretsView()
                    Spacer()
                        .frame(height: Config.vSpacerHeight)
                }
            } else {
                VStack {
                    if viewModel.devicesCount < Constants.Common.neededDeviceCount {
                        //Alert Bubble
                        VStack {
                            Spacer()
                                .frame(height: Config.vSpacerHeight)
                            AlertBubbleView()
                                .padding(.horizontal, Config.bubbleSideOffset)
                        }
                    }
                    List {
                        ForEach(viewModel.items, id: \.id) { item in
                            SecretCellView(item: item as! SecretModel)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: Config.bottomSpacer, trailing: 0))
                    }
                    .padding(.top, -Config.vSpacerHeight)
                    .scrollContentBackground(.hidden)
                }
            }
        }
    }
}

struct SecretsView_Previews: PreviewProvider {
    static var previews: some View {
        SecretsView()
    }
}

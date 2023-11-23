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
        static let vSpacerHeight: CGFloat = 60.0
        static let addSecretHeight: CGFloat = 344.0
        static let addDeviceHeight: CGFloat = 510.0
        static let bottomSpacer: CGFloat = 14.0
        static let animationDuration: CGFloat = 0.3
    }
    
    @StateObject var viewModel: SecretsViewModel = SecretsViewModel()
    
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
                    Spacer().frame(height: Config.vSpacerHeight)
                    EmptySecretsView()
                    Spacer()
                        
                }
            } else {
                ZStack {
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
                                Button(action: {
                                    withAnimation(.linear(duration: Config.animationDuration)) {
                                        viewModel.currentItem = item as? SecretModel
                                        viewModel.showSecret = true
                                    }
                                }) {
                                    SecretCellView(item: item as! SecretModel)
                                }
                                
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: Config.bottomSpacer, trailing: 0))
                        }
                        .padding(.top, (viewModel.devicesCount < Constants.Common.neededDeviceCount ? -30 : 0))
                        .scrollContentBackground(.hidden)
                    }
                    
                    if viewModel.showSecret {
                        ShowSecretView(showPopUp: $viewModel.showSecret, secretName: viewModel.currentItem?.description ?? "", secret: viewModel.currentItem?.secret ?? "")
                    }
                }
            }
        }
        .id(viewModel.isToReload)
        LoaderWithDimmingView(isLoading: $viewModel.isLoading)
    }
}

struct SecretsView_Previews: PreviewProvider {
    static var previews: some View {
        SecretsView()
    }
}

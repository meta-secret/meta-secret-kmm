//
//  PairDeviceView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 06.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct PairDeviceView: View {
    @State var selectedPage: Int = 1
    @State var viewModel: PairDeviceViewModel
    
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let height: CGFloat = 258
    }
    
    var body: some View {
        VStack {
            ZStack {
                AppColors.blackPopUps.ignoresSafeArea()
                VStack {
                    VStack {
                        HStack {
                            Spacer()
                            CloseButtonView(action: {})
                        }
                        .padding(.horizontal, 10.0)
                        HStack {
                            Text(Constants.Devices.addDevice)
                                .font(FontStyle.h1.font)
                                .foregroundColor(AppColors.white)
                            Spacer()
                        }
                        .padding(.horizontal, 16.0)
                        Spacer().frame(height: 24)
                    }
                    
                    ZStack {
                        VStack {
                            Spacer()
                                .frame(height: 160)
                            HStack {
                                Spacer()
                                PageControllView(selectedPage: $selectedPage, pages: viewModel.totalSteps, circleDiameter: Config.cornerRadius, circleMargin: Config.cornerRadius)
                                Spacer()
                            }
                        }

                        TabView(selection: $selectedPage) {
                            ForEach(viewModel.content, id: \.self) { content in
                                content.tag(content.pageType.rawValue)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .animation(.linear, value: UUID())
                        .transition(.slide)
                    }
                    .frame(height: 259)
                    
                    Spacer()
                        .frame(height: 24.0)
                    Rectangle()
                        .fill(AppColors.white10)
                        .frame(height: 1.0)
                        .ignoresSafeArea()
                    
                    Spacer()
                        .frame(height: 10.0)
                    Text(Constants.Devices.useQR)
                        .foregroundColor(AppColors.white75)
                        .font(FontStyle.normalMain.font)
                    
                    Spacer()
                        .frame(height: 24.0)
                    Image(AppImages.Common.fakeQR)
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct PairDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        PairDeviceView(viewModel: PairDeviceViewModel(pageType: .first))
    }
}

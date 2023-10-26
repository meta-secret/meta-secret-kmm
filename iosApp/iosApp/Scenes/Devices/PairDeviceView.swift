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
    @Environment(\.dismiss) var dismiss
    
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let height: CGFloat = 259
        static let spacerHeight: CGFloat = 160
        static let sideOffset: CGFloat = 16.0
        static let closeSideOffset: CGFloat = 10.0
        static let vSpacerHeight: CGFloat = 24.0
        static let bottomSpacerHeight: CGFloat = 30.0
        static let separatorHeight: CGFloat = 1.0
        static let qrCodeSize: CGFloat = 110.0
    }
    
    var body: some View {
        VStack {
            ZStack {
                // BG
                AppColors.blackPopUps.ignoresSafeArea()
                VStack {
                    VStack {
                        // Close button
                        VStack {
                            Spacer().frame(height: Config.closeSideOffset)
                            HStack {
                                Spacer()
                                CloseButtonView(action: { dismiss() })
                                Spacer().frame(width: Config.closeSideOffset)
                            }
                        }

                        // Title
                        VStack {
                            Spacer().frame(height: Config.vSpacerHeight)
                            HStack {
                                Spacer().frame(width: Config.sideOffset)
                                Text(Constants.Devices.addDevice)
                                    .font(FontStyle.h1.font)
                                    .foregroundColor(AppColors.white)
                                Spacer()
                            }
                        }
                    }
                    
                    // Page tutorial
                    ZStack {
                        VStack {
                            Spacer().frame(height: Config.spacerHeight)
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
                    .frame(height: Config.height)
                    
                    Spacer().frame(height: Config.vSpacerHeight)
                    
                    // Separator
                    Rectangle()
                        .fill(AppColors.white10)
                        .frame(height: Config.separatorHeight)
                        .ignoresSafeArea()
                    
                    Spacer().frame(height: Config.closeSideOffset)
                    
                    // Text scanner
                    Text(Constants.Devices.useQR)
                        .foregroundColor(AppColors.white75)
                        .font(FontStyle.normalMain.font)
                    
                    Spacer().frame(height: Config.vSpacerHeight)
                    // QR Code
                    Image(uiImage: viewModel.generateQRCode())
                        .resizable()
                        .scaledToFit()
                        .frame(width: Config.qrCodeSize, height: Config.qrCodeSize)
   
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

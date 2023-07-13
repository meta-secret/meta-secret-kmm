//
//  AddDeviceView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 27.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import Combine

struct AddDeviceView: View {
    private enum Config {
        static let cornerRadius: CGFloat = 12.0
        static let sideOffset: CGFloat = 16.0
        static let closeSideOffset: CGFloat = 10.0
        static let vSpacerHeight: CGFloat = 24.0
        static let bottomSpacerHeight: CGFloat = 30.0
    }
    
    @State private var showActionSheet: Bool = false
    @ObservedObject private var viewModel: AddDeviceViewModel = AddDeviceViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    // Bg
                    AppColors.blackPopUps.ignoresSafeArea()
                    
                    // Main container
                    VStack {
                        
                        //Close button
                        HStack {
                            Spacer()
                            CloseButtonView(action: {
                                dismiss()
                            })
                            Spacer()
                                .frame(width: Config.closeSideOffset)
                        }
                        
                        // Title
                        HStack {
                            Text(Constants.Devices.addDevice)
                                .font(FontStyle.h1.font)
                                .foregroundColor(AppColors.white)
                            Spacer()
                        }
                        .padding(.horizontal, Config.sideOffset)
                        Spacer().frame(height: Config.vSpacerHeight)
                        
                        // Subtitle
                        HStack {
                            Text(Constants.Devices.threeDevicesNeeded)
                                .font(FontStyle.normalMain.font)
                                .foregroundColor(AppColors.white75)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(.horizontal, Config.sideOffset)
                        Spacer().frame(height: Config.vSpacerHeight)
                        
                        // Banner view
                        CloudBannerView().padding(.horizontal, Config.sideOffset)
                        
                        // Button
                        VStack {
                            Spacer().frame(height: Config.vSpacerHeight)
                            HStack {
                                ActionBlueButton(title: "+ \(Constants.Devices.addDevice)", action: {
                                    showActionSheet = true
                                })
                            }
                            Spacer().frame(height: Config.bottomSpacerHeight)
                        }
                        .padding(.horizontal, Config.sideOffset)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showActionSheet, onDismiss: {
            showActionSheet = false
        }) {
            PairDeviceView(viewModel: PairDeviceViewModel(pageType: .first))
                .presentationDetents([.height(590)])
        }
    }
}

struct AddDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        AddDeviceView()
    }
}

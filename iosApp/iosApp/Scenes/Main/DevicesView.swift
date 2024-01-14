//
//  DevicesView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct DevicesView: View {
    private enum Config {
        static let bubbleSideOffset: CGFloat = 20.0
        static let vSpacerHeight: CGFloat = 30.0
        static let bottomSpacer: CGFloat = 14.0
    }
    
    @State var viewModel: DevicesViewModel = DevicesViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                if viewModel.devicesCount < Constants.Common.neededDeviceCount {
                    VStack {
                        Spacer()
                            .frame(height: Config.vSpacerHeight)
                        AlertBubbleView()
                            .padding(.horizontal, Config.bubbleSideOffset)
                    }
                }
                List {
                    ForEach(viewModel.items, id: \.id) { item in
                        DevicesCellView(item: item as! DeviceModel)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: Config.bottomSpacer, trailing: 0))
                }
                .padding(.top, (viewModel.devicesCount < Constants.Common.neededDeviceCount ? -30 : 0))
                .scrollContentBackground(.hidden)
            }
        }
        .id(viewModel.isToReload)
        .alert("Device \(viewModel.deviceAdd) trying to join to your local network.", isPresented: $showingAlert) {
            Button("Accept", role: .none) {
                viewModel.getContent(of: .device)
                showingAlert = false
            }
            Button("Discard", role: .cancel) { }
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView()
    }
}

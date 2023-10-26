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
        .onAppear {
            var counter = UserDefaults.standard.value(forKey: "deviceOpenCount") as! Int
            let iOSNumber = UserDefaults.standard.value(forKey: "iOSNumber") as! Int
            counter += 1
            print("counter = \(counter)")
            if counter == 2 && iOSNumber == 1 {
                viewModel.deviceAdd = counter == 2 ? "iPhone 13 Pro" : "Galaxy A04"
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    UserDefaults.standard.setValue(2, forKey: "deviceCount")
                    showingAlert = true
                    UserDefaults.standard.setValue(counter, forKey: "deviceOpenCount")
                })
            } else if (counter == 2 && iOSNumber == 2) || counter == 3 {
                viewModel.deviceAdd = "Galaxy A04"
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    UserDefaults.standard.setValue(3, forKey: "deviceCount")
                    showingAlert = true
                    UserDefaults.standard.setValue(counter, forKey: "deviceOpenCount")
                })
            } else {
                UserDefaults.standard.setValue(counter, forKey: "deviceOpenCount")
            }
        }
        .alert("Device \(viewModel.deviceAdd) trying to join to your local network.", isPresented: $showingAlert) {
            Button("Accept", role: .none) {
                var counter = UserDefaults.standard.value(forKey: "deviceOpenCount") as! Int
                let iOSNumber = UserDefaults.standard.value(forKey: "iOSNumber") as! Int
                
                if (counter == 2 && iOSNumber == 2) || (counter == 3 && iOSNumber == 1) {
                    UserDefaults.standard.setValue(3, forKey: "deviceCount")
                } else {
                    UserDefaults.standard.setValue(2, forKey: "deviceCount")
                }
                viewModel.getContent(of: .device)
                showingAlert = false
            }
            Button("Discard", role: .cancel) { }
        }
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView()
    }
}

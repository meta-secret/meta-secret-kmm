//
//  MainSceneView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import Combine

struct MainSceneView: View {
    
    private var secretsView = SecretsView()
    private var devicesView = DevicesView()
    
    private let notify = NotificationCenter.default.publisher(for: NSNotification.Name("distributionService"))
    @StateObject var viewModel: MainSceneViewModel = MainSceneViewModel()
    
    private enum Config {
        static let sideOffset: CGFloat = 16.0
        static let addSecretHeight: CGFloat = 320.0
        static let addDeviceHeight: CGFloat = 510.0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.Common.mainBg)
                    .resizable()
                    .ignoresSafeArea()
                
                //TabBar
                CustomTabView(action: {
                    viewModel.showActionSheet = true
                }, tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $viewModel.selectedIndex) { index in
                    let type = TabType(rawValue: index) ?? .secrets
                    getTabView(type: type)
                }
                
            }
            .ignoresSafeArea()
        }
        .onReceive(notify) { (notification) in
            guard let userNotification = notification.userInfo?["type"] as? CallBackType else { return }
            viewModel.switchCallback(userNotification) // TODO: Error alert
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Spacer()
                        .frame(height: Config.sideOffset * 2)
                    HStack {
                        Text(getNavTitle())
                            .font(FontStyle.header.font)
                            .foregroundColor(AppColors.white)
                        Spacer()
                    }
                }
            }
        }
        .navigationBarHidden(false)
        .sheet(isPresented: $viewModel.showActionSheet, onDismiss: {
            viewModel.showActionSheet = false
            viewModel.selectedTab = MainSceneViewModel.SelectedTab(rawValue: viewModel.selectedIndex) ?? .Secrets
        }) {
            if viewModel.selectedTab == .Devices {
                AddDeviceView()
                    .presentationDetents([.height(Config.addDeviceHeight)])
            } else {
                AddSecretView()
                    .presentationDetents([.height(Config.addSecretHeight)])
            }
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .secrets:
            secretsView
        case .devices:
            devicesView
        case .profile:
            ProfileView()
        }
    }
}

private extension MainSceneView {
    func getNavTitle() -> String {
        switch viewModel.selectedIndex {
        case MainSceneViewModel.SelectedTab.Secrets.rawValue:
            return Constants.Main.secrets
        case MainSceneViewModel.SelectedTab.Devices.rawValue:
            return Constants.Main.devices
        case MainSceneViewModel.SelectedTab.Profile.rawValue:
            return Constants.Main.profile
        default:
            return ""
        }
    }
}

struct MainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView()
    }
}

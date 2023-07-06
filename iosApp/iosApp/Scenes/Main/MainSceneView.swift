//
//  MainSceneView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MainSceneView: View {
    
    private enum Config {
        static let sideOffset: CGFloat = 16.0
    }
    
    @State private var selectedIndex: Int = 0
    @State private var showActionSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.Common.mainBg)
                    .resizable()
                    .ignoresSafeArea()
                
                CustomTabView(action: {
                    showActionSheet = true
                }, tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $selectedIndex) { index in
                    let type = TabType(rawValue: index) ?? .secrets
                    getTabView(type: type)
                }
                
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Spacer()
                        .frame(width: Config.sideOffset)
                    Text(getNavTitle())
                        .font(FontStyle.header.font)
                        .foregroundColor(AppColors.white)
                    Spacer()
                }
                .padding(.top)
            }
        }
        .navigationBarHidden(false)
        .sheet(isPresented: $showActionSheet, onDismiss: {
            showActionSheet = false
        }) {
            if selectedIndex == 1 {
                AddDeviceView()
                    .presentationDetents([.height(510)])
            } else {
                AddSecretView()
                    .presentationDetents([.height(344)])
            }
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .secrets:
            SecretsView()
        case .devices:
            DevicesView()
        case .plus:
            DevicesView()
        case .help:
            HelpView()
        case .profile:
            ProfileView()
        }
    }
}

private extension MainSceneView {
    func getNavTitle() -> String {
        switch selectedIndex {
        case 0:
            return Constants.Main.secrets
        case 1:
            return Constants.Main.devices
        case 3:
            return Constants.Main.help
        case 4:
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

//
//  MainSceneView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MainSceneView: View {
    
    @State var selectedIndex: Int = 0
    @State var showActionSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.mainBg)
                    .resizable()
                    .ignoresSafeArea()
                
                CustomTabView(tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $selectedIndex) { index in
                    let type = TabType(rawValue: index) ?? .secrets
                    getTabView(type: type)
                }
                
            }
            .ignoresSafeArea()
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("some actions"))
            }
        }
        .navigationBarBackButtonHidden(true)
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

struct MainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView()
    }
}

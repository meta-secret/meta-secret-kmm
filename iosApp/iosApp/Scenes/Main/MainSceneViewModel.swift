//
//  MainSceneViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 14.12.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import Combine
import OSLog

class MainSceneViewModel: CommonViewModel {
//    @Service private var distributionManager: DistributionProtocol
    
    @Published var selectedIndex: MainSceneViewModel.SelectedTab = .Secrets
    @Published var showActionSheet: Bool = false
    @Published var showPopup: Bool = false
    @Published var isToReload: Bool = false
    @Published var isToReDistribute = false
    @Published var selectedTab: Int = 0
    
    var secretsView: SecretsView? = nil
    var devicesView: DevicesView? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - LIFE CYCLE
    override init() {
        super.init()
        Logger().info("Load data for secrets")
//        loadData()
    }
}

extension MainSceneViewModel {
    enum SelectedTab: Int {
        case Secrets
        case Devices
        case Profile
    }
}

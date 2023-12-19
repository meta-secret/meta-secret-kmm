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
    //MARK: - SERVICES
    @Service private var distributionManager: DistributionProtocol
    @Service private var userService: UsersServiceProtocol
    @Service private var rustManager: RustProtocol
    @Service private var dbManager: DBManagerProtocol
    
    //MARK: - PROPERTIES
    @Published var selectedIndex: Int = 0
    @Published var showActionSheet: Bool = false
    @Published var showPopup: Bool = false
    @Published var isToReDistribute = false
    @Published var selectedTab: MainSceneViewModel.SelectedTab = .Secrets
    
    var secretsView: SecretsView? = nil
    var devicesView: DevicesView? = nil
    
    private var currentSecretIndex: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - LIFE CYCLE
    override init() {
        super.init()
        Logger().info("Load data for secrets")
//        loadData()
    }
    
    //MARK: - CALL BACK FROM DISTRIBUTION SERVICE
    func switchCallback(_ notification: CallBackType) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            switch notification {
            case .Shares:
                if self.selectedTab == .Secrets {
                    self.secretsView?.viewModel.getAllLocalSecrets()
                        .sink { completion in
                            switch completion {
                            case .failure(let error):
                                self.isToReDistribute = false
                                promise(.failure(error))
                            case .finished:
                                promise(.success(()))
                            }
                        } receiveValue: { _ in
                            if self.isToReDistribute {
                                self.isToReDistribute = false
                                _ = self.reDistribue()
                            } else {
                                self.reloadData()
                                    .sink { completion in
                                        switch completion {
                                        case .finished:
                                            promise(.success(()))
                                        case .failure(let error):
                                            promise(.failure(error))
                                        }
                                    } receiveValue: {}.store(in: &self.cancellables)
                            }
                        }.store(in: &self.cancellables)
                }
            case .Devices:
                if self.selectedTab == .Devices {
                    self.devicesView?.viewModel.getLocalVaultMembers()
                        .sink { completion in
                            switch completion {
                            case .finished:
                                if self.isToReDistribute {
                                    self.isToReDistribute = false
                                    _ = self.reDistribue()
                                } else {
                                    self.reloadData()
                                        .sink { completion in
                                            switch completion {
                                            case .finished:
                                                promise(.success(()))
                                            case .failure(let error):
                                                promise(.failure(error))
                                            }
                                        } receiveValue: {}.store(in: &self.cancellables)
                                }
                            case .failure(_):
                                self.isToReDistribute = false
                                promise(.failure(MetaSecretErrorType.distribute))
                            }
                        } receiveValue: {}.store(in: &self.cancellables)
                }
            case .Claims(let decriptedSecret, let descriptionName):
                if self.userService.needDBRedistribution, let decriptedSecret, let descriptionName {
                    self.dbRedistribution(decriptedSecret, descriptionName: descriptionName)
                        .sink { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        } receiveValue: {}.store(in: &self.cancellables)

                } else {
                    break
                }
            case .Failure:
                self.isToReDistribute = false
                break
            }
        }
    }
    
    func reDistribue() -> Future<Void, Error> {
        return distributionManager.reDistribute()
    }
}

private extension MainSceneViewModel {
    //MARK: - TAB SELECTING
    func selectTab() -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            let index = self.selectedTab.rawValue
            self.selectedIndex = index
            //        selector.selectedSegmentIndex = index //TODO: Show screen
            //        addDeviceView.isHidden = viewModel.addDeviceViewHidden
            //        yourDevicesTitleLabel.text = viewModel.yourDeviceTitle
            //        setEmptyStatus()
            //        setAttributedTitle(viewModel.title)
            
            self.getNewDataSource()
                .sink { completion in
                    switch completion {
                    case .finished:
                        _ = self.reloadData()
                    case .failure:
                        promise(.failure(MetaSecretErrorType.commonError))
                    }
                } receiveValue: {}.store(in: &self.cancellables)
        }
    }
    
    func getNewDataSource() -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            switch self.selectedTab {
            case .Secrets:
                guard let secretsView = self.secretsView else {
                    promise(.failure(MetaSecretErrorType.commonError))
                    return
                }
                secretsView.viewModel.getAllLocalSecrets()
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure:
                            promise(.success(()))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)

            case .Devices:
                guard let devicesView = self.devicesView else {
                    promise(.failure(MetaSecretErrorType.commonError))
                    return
                }
                devicesView.viewModel.getLocalVaultMembers()
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure:
                            promise(.success(()))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)
            default:
                promise(.success(()))
            }
        }
    }
    
    func reloadData() -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            /// ONLY for first launch
            if self.items.isEmpty == true && self.selectedTab == .Secrets && self.userService.isFirstAppLaunch {
                self.userService.isFirstAppLaunch = false
                self.selectedTab = .Devices
                
                if self.userService.shouldShowVirtualHint && self.userService.isOwner {
                    self.remainigLabelTapped()
                }
                self.selectTab()
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)
                return
            }
            
            if self.items.isEmpty == false {
                self.isToReload = true
                
                //            remainigLabel.text = viewModel.remainingDevicesText
                //            self.remainingNotificationContainer.isHidden = viewModel.remainingNotificationContainerHidden
                //            self.remainingNotification.showShadow()
            } else {
                self.isToReload = true
            }
        }
    }
    
    func dbRedistribution(_ secret: String, descriptionName: String) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            let components = self.rustManager.split(secret: secret)
            guard !components.isEmpty,
                  let signatures = self.userService.mainVault?.signatures,
                  signatures.count <= Constants.Common.neededMembersCount else {
                self.currentSecretIndex += 1
                self.dbRedistributionAsk()
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)

                return
            }
            
            self.distributionManager.distributeShares(components, signatures, descriptionName: descriptionName)
                .sink { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: {}.store(in: &self.cancellables)
            
            self.currentSecretIndex += 1
            self.dbRedistributionAsk()
                .sink { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: {}.store(in: &self.cancellables)
        }
    }
    
    private func dbRedistributionAsk() -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            let allSecrets = self.dbManager.getAllSecrets()
            if self.currentSecretIndex < allSecrets.count {
                let currentSecret = allSecrets[self.currentSecretIndex]
                self.distributionManager.startMonitoringClaimResponses(descriptionName: currentSecret.secretName)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)
                
            } else {
                self.isLoading = false
                self.userService.needDBRedistribution = false
                self.currentSecretIndex = 0
            }
        }
    }
    
    //MARK: - ROUTING
    @objc func remainigLabelTapped() {
//        let model = BottomInfoSheetModel(title: Constants.MainScreen.titleFirstTimeHint,
//                                         message: Constants.MainScreen.messageFirstTimeHint(name: userService.userSignature?.vaultName ?? ""), buttonHandler: { [weak self] in
//            self?.userService.shouldShowVirtualHint = false
//        })
//        let controller = factory.popUpHint(with: model)
//        popUp(controller)
    }
}

extension MainSceneViewModel {
    enum SelectedTab: Int {
        case Secrets
        case Devices
        case Profile
    }
}

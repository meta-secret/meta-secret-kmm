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
    @Service private var vaultApiService: VaultAPIProtocol
    @Service private var biometricManager: BiometricsManagerProtocol
    
    //MARK: - PROPERTIES
    @Published var selectedIndex: Int = 0
    @Published var showActionSheet: Bool = false
    @Published var isToReDistribute = false
    @Published var showDBInconsistencyAlert = false
    
    @Published var selectedTab: MainSceneViewModel.SelectedTab = .Secrets
    
    var secretsView: SecretsView? = nil
    var devicesView: DevicesView? = nil
    
    private var currentSecretIndex: Int = 0
    var cancellables = Set<AnyCancellable>()
    
    private var pendings: [VaultDoc]? = nil
    
    //MARK: - LIFE CYCLE
    override init() {
        super.init()
        Logger().info("Load data for secrets")
        loadData()
        _ = reloadData()
    }
    
    override func onAppear() {
        if userService.needDBRedistribution {
            showDBInconsistencyAlert = true
        }
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
                                self.showErrorAlert(error.localizedDescription)
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
                                            self.showErrorAlert(error.localizedDescription)
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
                                    self.reDistribue()
                                        .sink { completion in
                                            switch completion {
                                            case .finished:
                                                _ = self.reloadData()
                                            case .failure(let error):
                                                self.showErrorAlert(error.localizedDescription)
                                            }
                                        } receiveValue: {}.store(in: &self.cancellables)

                                } else {
                                    self.reloadData()
                                        .sink { completion in
                                            switch completion {
                                            case .finished:
                                                promise(.success(()))
                                            case .failure(let error):
                                                self.showErrorAlert(error.localizedDescription)
                                                promise(.failure(error))
                                            }
                                        } receiveValue: {}.store(in: &self.cancellables)
                                }
                            case .failure(let error):
                                self.isToReDistribute = false
                                self.showErrorAlert(error.localizedDescription)
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
                                self.showErrorAlert(error.localizedDescription)
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
    
    //MARK: - PUBLIC METHODS (Pairing)
    func acceptUser(candidate: UserSignature) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            self.vaultApiService.accept(candidate)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { result in
                    self.checkResult(result: result)
                        .sink { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        } receiveValue: {}.store(in: &self.cancellables)

                }.store(in: &self.cancellables)
        }
    }
    
    func declineUser(candidate: UserSignature) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            self.vaultApiService.decline(candidate)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { result in
                    self.checkResult(result: result)
                        .sink { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        } receiveValue: {}.store(in: &self.cancellables)
                }.store(in: &self.cancellables)
        }
    }
    
    private func checkResult(result: AcceptResult) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            guard result.msgType == Constants.Common.ok else {
                promise(.failure(MetaSecretErrorType.networkError))
                return
            }
            promise(.success(()))
        }
    }
    
    func selectedDevice(content: CellSetupDate) -> UserSignature? {
        let declines = userService.mainVault?.declinedJoins ?? []
        let pendings = userService.mainVault?.pendingJoins ?? []
        let signatures = userService.mainVault?.signatures ?? []
        let flattenArray = declines + pendings + signatures
        let selectedItem = flattenArray.first(where: {$0.device.deviceId == content.id })
        return selectedItem
    }
    
    func needDBRedistribution() -> Bool {
        return dbManager.getAllSecrets().first(where: {$0.shares.count == 1}) != nil
    }
    
    func reDistribue() -> Future<Void, Error> {
        return distributionManager.reDistribute()
    }

    func checkBiometricAllow() -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            let canEvaluate = self.biometricManager.canEvaluate()
            self.checEvaluation(canEvaluate)
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
}

private extension MainSceneViewModel {
    //MARK: - DATA LOADING
    func loadData() {
        isLoading = true
        
        guard let secretsView else { return }
        
        Publishers.Zip3(
            secretsView.viewModel.getAllLocalSecrets(),
            checkShares(),
            getVault()
        )
        .receive(on: DispatchQueue.main)
        .sink { completion in
            self.errorHandling(completion, error: .networkError)
        } receiveValue: { result in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            self.startMonitoringVaultsToConnect()
            self.startMonitoringSharesAndClaimRequests()
        }.store(in: &cancellables)
    }
    
    // MARK: - Distribution manager methods
    func checkShares() -> Future<Void, Error> {
        Logger().info("Start checking for new shares (.Split)")
        return distributionManager.findShares(type: .Split)
    }
    
    func getVault() -> Future<Void, Error> {
        Logger().info("Start checking for vault")
        return distributionManager.getVault()
    }
    
    func startMonitoringVaultsToConnect() {
        Logger().info("Start monitoring for new vaults to connect")
        distributionManager.startMonitoringVaults()
    }
    
    func startMonitoringSharesAndClaimRequests() {
        Logger().info("Start monitoring for new shares and claim requests")
        distributionManager.startMonitoringSharesAndClaimRequests()
    }
    
    
    
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
    
    func dbRedistributionAsk() -> Future<Void, Error> {
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
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                self.userService.needDBRedistribution = false
                self.currentSecretIndex = 0
            }
        }
    }
    
    func evaluation(success: Bool, error: BiometricError?) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            guard success else {
                promise(.failure(MetaSecretErrorType.alreadySavedMessage))
                return
            }
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
    
    func checEvaluation(_ canEvaluate: Bool) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            DispatchQueue.main.async {
                self.isLoading = true
            }
            guard canEvaluate else {
                self.dbRedistributionAsk()
                    .sink { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)
                promise(.success(()))
                return
            }
            
            self.biometricManager.evaluate()
                .sink { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { success, error in
                    self.evaluation(success: success, error: error)
                        .sink { completion in
                            promise(.success(()))
                        } receiveValue: {}.store(in: &self.cancellables)
                }.store(in: &self.cancellables)
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

private extension MainSceneViewModel {
    func acceptTapped(_ content: CellSetupDate) {
        var isThereError = false
        let selectedItem = selectedDevice(content: content)
        
        userService.needDBRedistribution = needDBRedistribution()
        guard let signature = selectedItem else { return }
        
        isLoading = true
        acceptUser(candidate: signature)
            .sink { completion in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                switch completion {
                case .failure(let error):
                    let text = (error as? MetaSecretErrorType)?.message() ?? error.localizedDescription
                    self.showErrorAlert(text)
                    isThereError = true
                case .finished:
                    if self.userService.needDBRedistribution {
                        self.showDBInconsistencyAlert = true
                    } else if !isThereError {
                        self.isToReDistribute = true
                        self.getVault()
                            .sink { completion in
                                switch completion {
                                case .finished:
                                    break
                                case .failure(let error):
                                    self.showErrorAlert(error.localizedDescription)
                                }
                            } receiveValue: {}.store(in: &self.cancellables)
                        _ = self.reloadData()
                    }
                }
            } receiveValue: {}.store(in: &self.cancellables)
        
    }
    
    func declineTapped(_ content: CellSetupDate) {
        var isThereError = false
        let selectedItem = selectedDevice(content: content)
        guard let signature = selectedItem else { return }
        
        isLoading = true
        declineUser(candidate: signature).sink { completion in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            switch completion {
            case .failure(let error):
                let text = (error as? MetaSecretErrorType)?.message() ?? error.localizedDescription
                self.showErrorAlert(text)
                isThereError = true
            case .finished:
                if !isThereError {
                    self.getVault()
                        .sink { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                self.showErrorAlert(error.localizedDescription)
                            }
                        } receiveValue: {}.store(in: &self.cancellables)
                    _ = self.reloadData()
                }
            }
        } receiveValue: {}.store(in: &self.cancellables)
    }
}

extension MainSceneViewModel {
    enum SelectedTab: Int {
        case Secrets
        case Devices
        case Profile
    }
}

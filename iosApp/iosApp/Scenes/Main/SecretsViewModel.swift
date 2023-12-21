//
//  SecretsViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 14.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import Combine
import OSLog

class SecretsViewModel: CommonViewModel {
    //MARK: - PROPERTIES
    @Service private var distributionManager: DistributionProtocol
    
    @Published var showSecret: Bool = false
    @Published var currentItem: SecretModel? = nil
    @Published var showingAlert: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - LIFE CYCLE
    override init() {
        super.init()
        Logger().info("Load data for secrets")
        loadData()
    }
    
    //MARK: - PUBLIC METHODS
    func getAllLocalSecrets() -> AnyPublisher<Void, Error> {
        Logger().info("Get All local secrets")
        return Future<Void, Error> { promise in
            self.getContent(of: .secrets)
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}

private extension SecretsViewModel {
    //MARK: - DATA LOADING
    func loadData() {
        isLoading = true
        
        Publishers.Zip3(
            getAllLocalSecrets(),
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
    
    // MARK: - VERSION TWO
    func getItems() {
        getContent(of: .secrets)
    }
}

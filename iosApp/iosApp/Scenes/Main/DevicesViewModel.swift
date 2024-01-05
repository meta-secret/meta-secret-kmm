//
//  DevicesViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import Combine
import OSLog

class DevicesViewModel: CommonViewModel {
    //MARK: - PROPERTIES
    @Service private var userService: UsersServiceProtocol
    @Service private var distributionManager: DistributionProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        getItems()
    }
    
    var deviceAdd = ""
    
    //MARK: - V1
    func getLocalVaultMembers() -> Future<Void, Error> {
        Logger().info("Get content: Devices")
        return Future<Void, Error> { promise in
            self.getContent(of: .device)
            if self.items.isEmpty {
                Logger().info("Get content: Devices are EMPTY")
                self.distributionManager.getVault()
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(_):
                            Logger().error("Error: \(MetaSecretErrorType.networkError)")
                            self.errorHandling(completion, error: .networkError)
                            promise(.failure(MetaSecretErrorType.networkError))
                        }
                    } receiveValue: { result in
                        DispatchQueue.main.async {
                            self.isLoading = false
                        }
                        Logger().info("Get content: Check again")
                        let _ = self.checkVaultResult()
                    }.store(in: &self.cancellables)
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                promise(.success(()))
            }
        }
    }
}

private extension DevicesViewModel {
    func getItems() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        getLocalVaultMembers()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.showErrorAlert(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: {}.store(in: &self.cancellables)

    }
    
    //MARK: - V1
    private func checkVaultResult() -> Future<Void, Error> {
        return Future { promise in
            guard let _ = self.userService.mainVault else {
                Logger().info("Error: \(MetaSecretErrorType.vaultError)")
                return promise( .failure(MetaSecretErrorType.vaultError))
            }
            
            Logger().info("Get content: Get device again")
            self.getContent(of: .device)
            return promise(.success(()))
        }
    }
}

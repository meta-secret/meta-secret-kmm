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
}

private extension DevicesViewModel {
    func getItems() {
        isLoading = true
        getLocalVaultMembers()
    }
    
    //MARK: - V1
    func getLocalVaultMembers() {
        Logger().info("Get content: Devices")
        getContent(of: .device)
        if items.isEmpty {
            Logger().info("Get content: Devices are EMPTY")
            distributionManager.getVault()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        Logger().error("Error: \(MetaSecretErrorType.networkError)")
                        self.errorHandling(completion, error: .networkError)
                    }
                } receiveValue: { result in
                    self.isLoading = false
                    Logger().info("Get content: Check again")
                    let _ = self.checkVaultResult()
                }.store(in: &cancellables)
        } else {
            isLoading = false
        }
    }
    
    private func checkVaultResult() -> Future<Void, Error> {
        return Future { promise in
            guard let mainVault = self.userService.mainVault else { 
                Logger().info("Error: \(MetaSecretErrorType.vaultError)")
                return promise( .failure(MetaSecretErrorType.vaultError))
            }
            
            Logger().info("Get content: Get device again")
            self.getContent(of: .device)
            return promise(.success(()))
        }
    }
}

//
//  SecretsViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 14.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import Combine

class SecretsViewModel: CommonViewModel {
    
    @Published var showSecret: Bool = false
    @Published var currentItem: SecretModel? = nil
    @Published var isToReload: Bool = false
    @Published var showingAlert: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        loadData()
    }
}

private extension SecretsViewModel {
    func loadData() {
        isLoading = true
        
//        Publishers.Zip3(
//            getAllLocalSecrets(),
//            checkShares(),
//            getVault()
//        )
//        .sink { completion in
//            self.errorHandling(completion, error: .networkError)
//        } receiveValue: { result in
//            self.isLoading = false
//            self.startMonitoringVaultsToConnect()
//            self.startMonitoringSharesAndClaimRequests()
//        }.store(in: &cancellables)
    }
    
    private func getAllLocalSecrets() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.getContent(of: .secrets)
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - VERSION TWO
    func getItems() {
        getContent(of: .secrets)
    }
}

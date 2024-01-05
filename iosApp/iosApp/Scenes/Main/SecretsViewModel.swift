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
    // MARK: - VERSION TWO
    func getItems() {
        getContent(of: .secrets)
    }
}

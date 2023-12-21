//
//  AddSecretViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 27.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication

class AddSecretViewModel: CommonViewModel {
    @Service private var contentManager: ContentManagerProtocol
    @Service private var rustManager: RustProtocol
    @Service private var dbManager: DBManagerProtocol
    @Service private var userService: UsersServiceProtocol
    @Service private var distributionManager: DistributionProtocol
    
    @Published private(set) var errors: [AddSecretErrorType] = [AddSecretErrorType]()
    @Published var secretName: String?
    @Published var secret: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var components: [UserShareDto] = [UserShareDto]()
    private var signatures: [UserSignature]? = nil
    private var descriptionName: String = ""
    private lazy var activeSignatures: [UserSignature] = [UserSignature]()
    
    var model: SceneSendDataModel? = nil
    
    var modeType: ModeType {
        return model?.modeType ?? .edit
    }
    
    var descriptionText: String {
        return model?.mainStringValue ?? ""
    }
    
    var descriptionHeaderText: String {
        return modeType == .edit ? Constants.AddSecret.addDescriptionTitle : Constants.AddSecret.description
    }
    
    var addPasswordHeaderText: String {
        return modeType == .edit ? Constants.AddSecret.addPassword : Constants.AddSecret.password
    }
    
    var title: String {
        return modeType == .readOnly ? Constants.AddSecret.recoverEdit : Constants.AddSecret.title
    }
    
    // MARK: Methods
    func loadData() -> Future<Void, Error> {
        isLoading = true
        return Future<Void, Error> { promise in
            self.getVault()
                .sink { completion in
                    switch completion {
                    case .finished:
                        self.isLoading = false
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: {}.store(in: &self.cancellables)
        }
    }
    
    //MARK: - PUBLIC METHODS
    func getVault() -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            self.signatures?.removeAll()
            self.signatures = self.userService.mainVault?.signatures
            if self.signatures?.count ?? 0 <= Constants.Common.neededMembersCount {
                self.activeSignatures = self.signatures ?? []
            }
            promise(.success(()))
        }
    }
    
    func vaultsCount() -> Int {
        return signatures?.count ?? 0
    }
    
    func split(secret: String, descriptionName: String) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            self.descriptionName = descriptionName
            
            if let _ = self.readMySecret(descriptionName: descriptionName) {
                promise(.failure(MetaSecretErrorType.alreadySavedMessage))
            } else {
                self.splitInternal(secret)
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
    
    func stopRestoring() {
        distributionManager.stopMonitoringClaimResponses()
    }
    
    func encryptAndDistribute() -> Future<Void, Error> {
        return distributionManager.distributeShares(components, activeSignatures, descriptionName: descriptionName)
    }
    
//    func showDeviceLists() -> Promise<Void> {
//        let model = SceneSendDataModel(signatures: signatures, callBackSignatures: { [weak self] signatures in
//            self?.activeSignatures = signatures
//            self?.encryptAndDistribute()
//        })
//        routeTo(.selectDevice, presentAs: .push, with: model)
//        return Promise().asVoid()
//    }
    
    func restore(descriptionName: String) {
        checkBiometricAllow(descriptionName)
    }
    
    private func checkBiometricAllow(_ descriptionName: String) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            let context = LAContext()
            var error: NSError?
            let reason = Constants.Alert.biometricalReason
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                    [weak self] success, authenticationError in
                    guard let self else {
                        promise(.failure(MetaSecretErrorType.commonError))
                        return
                    }
                        if success {
                            if self.userService.mainVault?.signatures?.count ?? 0 >= Constants.Common.neededMembersCount {
                                //TODO: ALERT!!!
//                                self?.alertManager.showCommonAlert(AlertModel(title: Constants.Alert.needConfirmation, message: Constants.Alert.waitConfirmationText, okButton: Constants.Alert.cancel, cancelButton: nil, okHandler: {
//                                    self?.distributionManager.stopMonitoringClaimResponses()
//                                }))
                            }
                            self.requestClaims(descriptionName)
                                .sink { completion in
                                    switch completion {
                                    case .finished:
                                        promise(.success(()))
                                    case .failure(let error):
                                        promise(.failure(error))
                                    }
                                } receiveValue: {}.store(in: &self.cancellables)
                        } else {
                            promise(.failure(MetaSecretErrorType.alreadySavedMessage))
                        }
                }
            } else {
                self.requestClaims(descriptionName)
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
    
    func requestClaims(_ descriptionName: String) -> Future<Void, Error>  {
        return distributionManager.startMonitoringClaimResponses(descriptionName: descriptionName)
    }
    
    func setErrors() {
        errors.removeAll()
        
        if secret.isEmptyOrNil {
            errors.append(.secret)
        }
        
        if secretName.isEmptyOrNil {
            errors.append(.secretName)
        }
    }
    
    func getError(by errortype: AddSecretErrorType) -> Bool {
        return errors.first(where: {$0 == errortype}) != nil
    }
    
    func saveSecret() {
        guard let secret, let secretName else { return }
        contentManager.saveSecret(description: secretName, secret: secret)
    }
}

#warning("Need common error handler manager")
enum AddSecretErrorType {
    case secret
    case secretName
    
    var errorText: String {
        switch self {
        case .secret:
            return Constants.Secrets.secretNeeded
        case .secretName:
            return Constants.Secrets.secretNameNeeded
        }
    }
}

private extension AddSecretViewModel {
    func splitInternal(_ secret: String) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            self.components = self.rustManager.split(secret: secret)
            if self.components.isEmpty {
                promise(.failure(MetaSecretErrorType.splitError))
                return
            }
            promise(.success(()))
        }
    }
    
    //MARK: - WORK WITH DB
    func readMySecret(descriptionName: String) -> Secret? {
        return dbManager.readSecretBy(descriptionName: descriptionName)
    }
}

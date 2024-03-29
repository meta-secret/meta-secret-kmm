//
//  ShareAPIService.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import Combine
import OSLog

protocol ShareAPIProtocol {
    func findShares(type: SecretDistributionType) -> Future<FindSharesResult, Error>
    func distribute(encodedShare: AeadCipherText,
                    receiver: UserSignature,
                    descriptionName: String,
                    type: SecretDistributionType) -> Future<DistributeResult, Error>
    func requestClaim(provider: UserSignature, secret: Secret) -> Future<ClaimResult, Error>
    func findClaims() -> Future<FindClaimsResult, Error>
}

class ShareAPIService: APIManager, ShareAPIProtocol {
    var cancellables = Set<AnyCancellable>()
    
    func distribute(encodedShare: AeadCipherText,
                    receiver: UserSignature,
                    descriptionName: String,
                    type: SecretDistributionType) -> Future<DistributeResult, Error> {
        
        return Future { promise in
            guard let mainVault = self.userService.mainVault,
                  let userSignature = self.userService.userSignature,
                  let metaPasswordId = self.rustManager.generateMetaPassId(descriptionName: descriptionName) else {
                promise(.failure(MetaSecretErrorType.userSignatureError))
                return
            }
            
            let secretMessage = EncryptedMessage(receiver: receiver, encryptedText: encodedShare)
            let metaPasswordDoc = MetaPasswordDoc(id: metaPasswordId, vault: mainVault)
            let metaPasswordRequest = MetaPasswordRequest(userSig: userSignature, metaPassword: metaPasswordDoc)
            let request = DistributeRequest(distributionType: type.rawValue,
                                            metaPassword: metaPasswordRequest,
                                            secretMessage: secretMessage)
            
            guard let params = self.jsonManager.jsonStringGeneration(from: request) else {
                promise(.failure(MetaSecretErrorType.objectToJson))
                return
            }
            
            self.fetchData(Distribute(params))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        promise(.failure(MetaSecretErrorType.networkError))
                    }
                } receiveValue: { result in
                    promise(.success(result))
                }.store(in: &self.cancellables)
        }
    }
    
    func findShares(type: SecretDistributionType) -> Future<FindSharesResult, Error> {
        return Future { promise in
            guard
                let userSignature = self.userService.userSignature else {
                promise(.failure(MetaSecretErrorType.userSignatureError))
                return
            }
            
            let model = FindSharesRequest(userRequestType: type, userSignature: userSignature)
            Logger().info("FindSharesRequest type \(type.rawValue)")
            guard let params = self.jsonManager.jsonStringGeneration(from: model) else {
                return promise(.failure(MetaSecretErrorType.userSignatureError))
            }
            
            Logger().info("Fetch data: Find shares")
            self.fetchData(FindShares(params))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        Logger().error("Error: MetaSecretErrorType.networkError")
                        promise(.failure(MetaSecretErrorType.networkError))
                    }
                } receiveValue: { (result: FindSharesResult) in
                    Logger().info("Found \(Int(result.data?.shares.count ?? 0)) share(s) of type \(type.rawValue)")
                    promise(.success(result))
                }.store(in: &self.cancellables)
        }
    }
    
    func requestClaim(provider: UserSignature, secret: Secret) -> Future<ClaimResult, Error> {
        return Future { promise in
            guard
                let userSignature = self.userService.userSignature,
                let metaPasswordId = self.rustManager.generateMetaPassId(descriptionName: secret.secretName)
            else {
                promise(.failure(MetaSecretErrorType.userSignatureError))
                return
            }
            
            let request = PasswordRecoveryRequest(id: metaPasswordId,
                                                  consumer: userSignature,
                                                  provider: provider)
            
            guard let params = self.jsonManager.jsonStringGeneration(from: request) else {
                promise(.failure(MetaSecretErrorType.objectToJson))
                return
            }
            
            self.fetchData(Claim(params))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        promise(.failure(MetaSecretErrorType.networkError))
                    }
                } receiveValue: { result in
                    promise(.success(result))
                }.store(in: &self.cancellables)

        }
    }
    
    func findClaims() -> Future<FindClaimsResult, Error> {
        return Future { promise in
            guard
                let userSignature = self.userService.userSignature,
                let params = self.jsonManager.jsonStringGeneration(from: userSignature)
            else {
                Logger().error("Error: \(MetaSecretErrorType.userSignatureError)")
                promise(.failure(MetaSecretErrorType.userSignatureError))
                return
            }
            
            Logger().info("Fetch data: Find claims")
            self.fetchData(FindClaims(params))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        Logger().error("Error: \(MetaSecretErrorType.networkError)")
                        promise(.failure(MetaSecretErrorType.networkError))
                    }
                } receiveValue: { (result: FindClaimsResult) in
                    Logger().info("Got: \(result.msgType ?? "NaN")")
                    promise(.success(result))
                }
                .store(in: &self.cancellables)

        }
    }
    
}


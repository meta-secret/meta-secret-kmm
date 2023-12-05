//
//  VaultAPIService.swift
//  MetaSecret
//
//  Created by Dmitry Kuklin on 02.01.2023.
//

import SwiftUI
import Combine
import OSLog

protocol VaultAPIProtocol {
    func getVault(_ user: UserSignature?) -> Future<GetVaultResult, Error>
    func accept(_ candidate: UserSignature) -> Future<AcceptResult, Error>
    func decline(_ candidate: UserSignature) -> Future<AcceptResult, Error>
}

class VaultAPIService: APIManager, VaultAPIProtocol {
    var cancellables = Set<AnyCancellable>()
    
    func getVault(_ user: UserSignature? = nil) -> Future<GetVaultResult, Error> {
        return Future<GetVaultResult, Error> { promise in
            guard let userSignature = user ?? self.userService.userSignature,
                  let params = self.jsonManager.jsonStringGeneration(from: userSignature)
            else {
                Logger().error("Error: \(MetaSecretErrorType.userSignatureError)")
                promise(.failure(MetaSecretErrorType.userSignatureError))
                return
            }
            
            Logger().info("Fetch data for Vault")
            self.fetchData(GetVault(params))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        Logger().error("Error: \(MetaSecretErrorType.networkError)")
                        promise(.failure(MetaSecretErrorType.networkError))
                    }
                } receiveValue: { (result: GetVaultResult) in
                    Logger().info("Got: \(result.data?.vault?.vaultName ?? "NaN")")
                    promise(.success(result))
                }.store(in: &self.cancellables)
        }
    }
    
    func accept(_ candidate: UserSignature) -> Future<AcceptResult, Error> {
        return Future { promise in
            guard let userSignature = self.userService.userSignature else {
                promise(.failure(MetaSecretErrorType.userSignatureError))
                return
            }
            
            let request = AcceptRequest(member: userSignature, candidate: candidate)
            guard let params = self.jsonManager.jsonStringGeneration(from: request) else {
                promise(.failure(MetaSecretErrorType.networkError))
                return
            }
            
            let future: Future<AcceptResult, Error> = self.fetchData(Accept(params))
            future.sink { completion in
                switch completion {
                case .failure(let error):
                    promise(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { result in
                promise(.success(result))
            }
        }
    }
    
    func decline(_ candidate: UserSignature) -> Future<AcceptResult, Error> {
        return Future { promise in
            guard let userSignature = self.userService.userSignature else {
                promise(.failure(MetaSecretErrorType.userSignatureError))
                return
            }
            
            let request = AcceptRequest(member: userSignature, candidate: candidate)
            guard let params = self.jsonManager.jsonStringGeneration(from: request) else {
                promise(.failure(MetaSecretErrorType.networkError))
                return
            }
            
            let future: Future<AcceptResult, Error> = self.fetchData(Decline(params))
            future.sink { completion in
                switch completion {
                case .failure(let error):
                    promise(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { result in
                promise(.success(result))
            }
        }
    }
}

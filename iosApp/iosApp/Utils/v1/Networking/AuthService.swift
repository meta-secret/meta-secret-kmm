//
//  AuthorizationService.swift
//  MetaSecret
//
//  Created by Dmitry Kuklin on 02.01.2023.
//

import Combine

protocol AuthorizationProtocol {
    func register(_ user: UserSignature) -> Future<RegisterResult, Error>
}

class AuthorisationService: APIManager, AuthorizationProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    func register(_ user: UserSignature) -> Future<RegisterResult, Error> {
        return Future { promise in
            guard let params = self.jsonManager.jsonStringGeneration(from: user) else {
                promise(.failure(MetaSecretErrorType.userSignatureError))
                return
            }
            
            self.fetchData(Register(params))
                .sink { completion in
                switch completion {
                case .failure(let error):
                    promise(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { result in
                promise(.success(result))
            }.store(in: &self.cancellables)
        }
    }
}


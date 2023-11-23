//
//  SignInViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 11.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class SignInViewModel: CommonViewModel {
    @Service private var authManager: AuthManagerProtocol
    @Service private var signingManager: Signable
    @Service private var vaultService: VaultAPIProtocol
    @Service private var userService: UsersServiceProtocol
    @Service private var authService: AuthorizationProtocol
    
    @Published var nickName: String?
    @Published var isNext = false
    @Published var isQrCodeScanner = false
    
    var titleText: String {
        return Constants.LetsStart.letsStart
    }
    
    var descriptionText: String {
        return Constants.LetsStart.chooseName
    }
    
    var placeholder: String {
        return Constants.LetsStart.chooseNamePlaceHolder
    }
    
    var scanQrText: String {
        return Constants.LetsStart.scanQR
    }
    
    var nextButtonText: String {
        return Constants.LetsStart.moveNext
    }
    
    private var tempTimer: Timer? = nil
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - REGISTRATION
    
    ///Firs of all we need to check chosen name. Is it available or not
    func checkAndSaveName(name: String) {
        isLoading = true // To show spinner
        
        guard let userSecurityBox = signingManager.generateKeys(for: name) else {
            textError = Constants.Errors.swwError
            isError = true
            return
        }
        
        let user = UserSignature(vaultName: name,
                                 signature: userSecurityBox.signature,
                                 publicKey: userSecurityBox.keyManager.dsa.publicKey,
                                 transportPublicKey: userSecurityBox.keyManager.transport.publicKey,
                                 device: Device())
        
        //Check vault na,e
        vaultService.getVault(user)
            .sink { completion in
                self.errorHandling(completion, error: MetaSecretErrorType.vaultError)
            } receiveValue: { result in
                if result.data?.vaultInfo == .Unknown {
                    self.userService.deviceStatus = .Pending
                    self.userService.userSignature = user
                    self.userService.securityBox = userSecurityBox
                    self.isLoading = false
                } else if result.data?.vaultInfo == .NotFound {
                    //No such name, let's register it
                    self.register(user, userSecurityBox, isOwner: true)
                        .sink(receiveCompletion: { completion in
                            self.errorHandling(completion, error: MetaSecretErrorType.registerError)
                        }, receiveValue: { result in
                            self.isError = false
                            self.isLoading = false
                            self.isNext = true
                        }).store(in: &self.cancellables)
                } else {
                    self.userService.userSignature = nil
                    self.userService.securityBox = nil
                    self.userService.deviceStatus = .Unknown
                    self.isLoading = false
                }
            }.store(in: &cancellables)
    }
}

private extension SignInViewModel {
    func register(_ user: UserSignature, _ userSecurityBox: UserSecurityBox, isOwner: Bool) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            self.authService.register(user)
                .sink(receiveCompletion: { completion in
                    self.errorHandling(completion, error: MetaSecretErrorType.registerError)
                }, receiveValue: { result in
                    self.userService.userSignature = user
                    self.userService.securityBox = userSecurityBox
                    if result.data == .Registered {
                        self.userService.deviceStatus = .Member
                        self.tempTimer?.invalidate()
                        self.tempTimer = nil
                        promise(.success(()))
                    } else {
                        self.startTimer() // Need to subscribe on timer action
                    }
                }).store(in: &self.cancellables)
        }
    }
    
    func startTimer() {
        guard self.tempTimer == nil else { return }
        //        delegate?.showPendingPopup()
        tempTimer = Timer.scheduledTimer(timeInterval: Constants.Common.timerInterval, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        checkStatus()
    }
    
    func checkStatus() -> AnyPublisher<Void, Error> {
        if userService.deviceStatus == .Pending {
            return Future<Void, Error> { promise in
                self.vaultService.getVault(nil)
                    .sink { completion in
                        self.errorHandling(completion, error: .vaultError)
                    } receiveValue: { result in
                        if result.data?.vaultInfo == .Member {
                            self.userService.deviceStatus = .Member
                            self.tempTimer?.invalidate()
                            self.tempTimer = nil
                            //                            self.delegate?.closePopUp()
                            //                            self.delegate?.routeNext()
                        } else if result.data?.vaultInfo == .Declined {
                            //                            self.delegate?.closePopUp()
                            self.userService.resetAll()
                            //                            self.delegate?.failed(with: MetaSecretErrorType.declinedUser)
                        } else {
                            self.startTimer()
                        }
                        self.isLoading = false
                        promise(.success(()))
                    }.store(in: &self.cancellables)
            }.eraseToAnyPublisher()
        } else {
            return Result.Publisher(()).eraseToAnyPublisher()
        }
    }
}

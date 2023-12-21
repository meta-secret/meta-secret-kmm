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
import OSLog

class SignInViewModel: CommonViewModel {
    @Service private var signingManager: Signable
    @Service private var vaultService: VaultAPIProtocol
    @Service private var userService: UsersServiceProtocol
    @Service private var authService: AuthorizationProtocol
    @Service private var authManager: AuthManagerProtocol
    
    @Published var nickName: String?
    @Published var isNext = false
    @Published var isQrCodeScanner = false
    @Published var showPendingPopup = false
    @Published var showAwaitingAlert = false
    @Published var showAlreadyExisted = false
    @Published var routeNext = false
    
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
    
    override init() {
        super.init()
        Logger().info("Load data for secrets")
        loadData()
    }
    
    //MARK: - DATA LOADING
    func loadData() {
        Logger().info("Check Registration status")
        self.isLoading = true
        
        self.checkStatus()
            .sink { completion in
                self.errorHandling(completion, error: .registerError)
            } receiveValue: {}.store(in: &self.cancellables)
    }
    
    //MARK: - REGISTRATION
    func registration() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        Logger().info("Register existed user vault")
        guard let securityBox = userService.securityBox,
              let user = userService.userSignature else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            //TODO: Need any notification
            return
        }
        
        let _ = register(user, securityBox, isOwner: false)
    }
    
    ///Firs of all we need to check chosen name. Is it available or not (v1 preRegistrationChecking)
    func checkAndSaveName(name: String) {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        Logger().info("Generate keys")
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
        
        //Check vault name
        vaultService.getVault(user)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.errorHandling(completion, error: MetaSecretErrorType.vaultError)
            } receiveValue: { result in
                if result.data?.vaultInfo == .Unknown {
                    Logger().info("Vault pending. Waiting for approval")
                    self.userService.deviceStatus = .Pending
                    self.userService.userSignature = user
                    self.userService.securityBox = userSecurityBox
                    DispatchQueue.main.async {
                        self.showAlreadyExisted = true
                        self.isLoading = false
                    }
                } else if result.data?.vaultInfo == .NotFound {
                    Logger().info("No vault. Let's register it")
                    self.register(user, userSecurityBox, isOwner: true)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            self.errorHandling(completion, error: MetaSecretErrorType.registerError)
                        }, receiveValue: { result in
                            Logger().info("Vault registered")
                            self.authManager.register(with: user.vaultName)
                            
                            DispatchQueue.main.async {
                                self.isError = false
                                self.isLoading = false
                                self.isNext = true
                            }
                        }).store(in: &self.cancellables)
                } else {
                    Logger().info("Vault unknown status")
                    self.userService.userSignature = nil
                    self.userService.securityBox = nil
                    self.userService.deviceStatus = .Unknown
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }.store(in: &cancellables)
    }
    
    //MARK: - User service setting status
    func setStatus(_ status: VaultInfoStatus) {
        Logger().info("Set vault status: \(status.rawValue)")
        self.userService.deviceStatus = status
        self.closePopUp()
    }
    
    func resetStatus() {
        Logger().info("Reset vault")
        self.userService.resetAll()
        self.nickName = nil
        self.closePopUp()
    }
    
    func closePopUp() {
        showPendingPopup = false
        showAwaitingAlert = false
        showAlreadyExisted = false
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
                        self.startTimer()
                    }
                }).store(in: &self.cancellables)
        }
    }
    
    func startTimer() {
        guard self.tempTimer == nil else { return }
        DispatchQueue.main.async {
            self.isLoading = false
            self.showPendingPopup = true
        }
        tempTimer = Timer.scheduledTimer(timeInterval: Constants.Common.timerInterval, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        _ = checkStatus()
    }
    
    func checkStatus() -> AnyPublisher<Void, Error> {
        if userService.deviceStatus == .Pending {
            return Future<Void, Error> { promise in
                self.vaultService.getVault(nil)
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        self.errorHandling(completion, error: .vaultError)
                    } receiveValue: { result in
                        if result.data?.vaultInfo == .Member {
                            self.userService.deviceStatus = .Member
                            self.tempTimer?.invalidate()
                            self.tempTimer = nil
                            self.closePopUp()
                            self.routeNext = true
                        } else if result.data?.vaultInfo == .Declined {
                            self.closePopUp()
                            self.userService.resetAll()
                            promise(.failure(MetaSecretErrorType.declinedUser))
                        } else {
                            self.startTimer()
                        }
                        DispatchQueue.main.async {
                            self.isLoading = false
                        }
                        promise(.success(()))
                    }.store(in: &self.cancellables)
            }.eraseToAnyPublisher()
        } else {
            return Result.Publisher(()).eraseToAnyPublisher()
        }
    }
}

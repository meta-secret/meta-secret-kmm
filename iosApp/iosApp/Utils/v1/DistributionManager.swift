//
//  DistributionManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 15.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import Combine
import RealmSwift
import OSLog

protocol DistributionProtocol {
    func startMonitoringSharesAndClaimRequests()
    func startMonitoringVaults()
    func startMonitoringClaimResponses(descriptionName: String) -> Future<Void, Error>
    func stopMonitoringClaimResponses()
    func getVault() -> Future<Void, Error>
    func findShares(type: SecretDistributionType) -> Future<Void, Error>
    func reDistribute() -> Future<Void, Error>
    
    func distributeShares(_ shares: [UserShareDto], _ signatures: [UserSignature], descriptionName: String) -> Future<Void, Error>
    func distribtuteToDB(_ shares: [SecretDistributionDoc]?) -> Future<Void, Error>
    func encryptShare(_ share: UserShareDto, _ receiverPubKey: Base64EncodedText) -> AeadCipherText?
}

final class DistributionManager: NSObject, DistributionProtocol  {
    //MARK: - PROPERTIES
    fileprivate enum SplittedType: Int {
        case fullySplitted = 3
        case allInOne = 1
        case partially = 2
    }
    
    private var shares: [UserShareDto] = [UserShareDto]()
    private var signatures: [UserSignature] = [UserSignature]()
    private var secretDescription: String = ""
    
    private var findSharesAndClaimRequestsTimer: Timer? = nil
    private var findVaultsTimer: Timer? = nil
    private var findClaimResponsesTimer: Timer? = nil
    
    private var isNeedToRedistribute: Bool = false
    private var isNeedToSearching: Bool = true
    private var needToRecover: Bool = false
    private let nc = NotificationCenter.default
    
    private var userService: UsersServiceProtocol
    private let jsonManager: JsonSerealizable
    private let dbManager: DBManagerProtocol
    private let rustManager: RustProtocol
    private let vaultService: VaultAPIProtocol
    private let shareService: ShareAPIProtocol
    
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - INIT
    init(userService: UsersServiceProtocol, jsonManager: JsonSerealizable, dbManager: DBManagerProtocol, rustManager: RustProtocol, vaultService: VaultAPIProtocol, shareService: ShareAPIProtocol) {
        self.userService = userService
        self.jsonManager = jsonManager
        self.dbManager = dbManager
        self.rustManager = rustManager
        self.vaultService = vaultService
        self.shareService = shareService
    }
    
    //MARK: - MAIN SCREEN. SHARES
    ///This method for monitoring on MianScreen Secrets tab
    func startMonitoringSharesAndClaimRequests() {
        if findSharesAndClaimRequestsTimer == nil {
            findSharesAndClaimRequestsTimer = Timer.scheduledTimer(timeInterval: Constants.Common.timerInterval, target: self, selector: #selector(fireSharesAndClaimRequestsTimer), userInfo: nil, repeats: true)
        }
    }
    
    //MARK: - MAIN SCREEN. VAULTS
    func startMonitoringVaults() {
        if findVaultsTimer == nil {
            findVaultsTimer = Timer.scheduledTimer(timeInterval: Constants.Common.timerInterval, target: self, selector: #selector(fireVaultsTimer), userInfo: nil, repeats: true)
        }
    }
    
    //MARK: - ADD SECRET SCREEN. CLAIMS
    func startMonitoringClaimResponses(descriptionName: String) -> Future<Void, Error> {
        return Future { promise in
            self.askingForClaims(descriptionName: descriptionName)
                .sink { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        let text = (error as? MetaSecretErrorType)?.message() ?? error.localizedDescription
                        self.nc.post(name: NSNotification.Name(rawValue: "distributionService"), object: nil, userInfo: ["type": CallBackType.Failure])
                        promise(.failure(MetaSecretErrorType.networkError))
                    }
                } receiveValue: { _ in
                    if self.findClaimResponsesTimer == nil {
                        self.findClaimResponsesTimer = Timer.scheduledTimer(timeInterval: Constants.Common.timerInterval, target: self, selector: #selector(self.fireClaimResponsesTimer), userInfo: nil, repeats: true)
                    }
                }.store(in: &self.cancellables)
        }
    }
    
    func stopMonitoringClaimResponses() {
        findClaimResponsesTimer?.invalidate()
        findClaimResponsesTimer = nil
    }
    
    //MARK: - ADD SECRET SCREEN SPLIT
    func distributeSharesToMembers(_ shares: [UserShareDto], signatures: [UserSignature], descriptionName: String) -> Future<Void, Error> {
            Future<Void, Error> { promise in
                var futures = [Future<DistributeResult, Error>]()
                for i in 0..<shares.count {
                    let signature: UserSignature
                    let shareToEncrypt = shares[i]
                    if signatures.count > i {
                        signature = signatures[i]
                    } else {
                        signature = signatures[0]
                    }

                    if let encryptedShare = self.encryptShare(shareToEncrypt, signature.transportPublicKey) {
                        for share in [encryptedShare] {
                            let future = self.distribution(encodedShare: share, receiver: signature, descriptionName: descriptionName, type: .Split)
                            futures.append(future)
                        }
                    }
                }

                Publishers.MergeMany(futures)
                    .collect()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }, receiveValue: { results in
                        self.commonResultHandler(result: results)
                            .sink(receiveCompletion: { completion in
                                switch completion {
                                case .finished:
                                    promise(.success(()))
                                case .failure(let error):
                                    promise(.failure(error))
                                }
                            }, receiveValue: {})
                            .store(in: &self.cancellables)
                    })
                    .store(in: &self.cancellables)
            }
        }

    func getVault() -> Future<Void, Error> {
        return Future { promise in
            self.vaultService.getVault(nil)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        Logger().error("Error: \(MetaSecretErrorType.networkError)")
                        promise(.failure(MetaSecretErrorType.networkError))
                    }
                } receiveValue: { (result: GetVaultResult) in
                    Logger().info("Got \(result.data?.vault?.vaultName ?? "Nan")")
                    self.commonResultHandler(result: result)
                        .sink { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(_):
                                Logger().error("Error: \(MetaSecretErrorType.networkError)")
                                promise(.failure(MetaSecretErrorType.networkError))
                            }
                        } receiveValue: {}.store(in: &self.cancellables)
                }.store(in: &self.cancellables)
        }
    }
    
    func findShares(type: SecretDistributionType) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            self.shareService.findShares(type: type)
                .sink { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(_):
                        Logger().error("Error: \(MetaSecretErrorType.shareSearchError)")
                        promise(.failure(MetaSecretErrorType.shareSearchError))
                    }
                } receiveValue: { (result: FindSharesResult) in
                    self.commonResultHandler(result: result)
                        .sink { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(_):
                                Logger().error("Error: \(MetaSecretErrorType.commonError)")
                                promise(.failure(MetaSecretErrorType.commonError))
                            }
                        } receiveValue: {}
                        .store(in: &self.cancellables)
                    
                }.store(in: &self.cancellables)
        }
    }

    func reDistribute() -> Future<Void, Error> {
            Future<Void, Error> { promise in
                guard let signatures = self.userService.mainVault?.signatures else {
                    promise(.failure(MetaSecretErrorType.distribute))
                    return
                }

                let allSecrets = self.dbManager.getAllSecrets()
                var futures = [Future<Void, Error>]()

                for secret in allSecrets {
                    let sharesArray = Array(secret.shares)
                    guard let shareString = sharesArray.first,
                        let shareObject: SecretDistributionDoc = try? self.jsonManager.objectGeneration(from: shareString),
                        let securityBox = self.userService.securityBox,
                        let shareStringLast = sharesArray.last,
                        let shareObjectLast: SecretDistributionDoc = try? self.jsonManager.objectGeneration(from: shareStringLast) else {
                            promise(.failure(MetaSecretErrorType.distribute))
                            return
                    }

                    let model = RestoreModel(keyManager: securityBox.keyManager, docOne: shareObject, docTwo: shareObjectLast)
                    guard let decryptedSecret = self.rustManager.restoreSecret(model: model) else {
                        promise(.failure(MetaSecretErrorType.distribute))
                        return
                    }
                    let components = self.rustManager.split(secret: decryptedSecret)

                    let future = self.distributeShares(components, signatures, descriptionName: secret.secretName)
                    futures.append(future)
                }

                Publishers.MergeMany(futures)
                    .collect()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }, receiveValue: { results in
                        self.commonResultHandler(result: results)
                            .sink(receiveCompletion: { completion in
                                switch completion {
                                case .finished:
                                    promise(.success(()))
                                case .failure(let error):
                                    promise(.failure(error))
                                }
                            }, receiveValue: {})
                            .store(in: &self.cancellables)
                    })
                    .store(in: &self.cancellables)
            }
        }
    
    
    //MARK: - SHARES DISTRIBUTION
    func distributeShares(_ shares: [UserShareDto], _ signatures: [UserSignature], descriptionName: String) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            guard let typeOfSharing = SplittedType(rawValue: signatures.count) else {
                promise(.failure(MetaSecretErrorType.distribute))
                return
            }
            
            self.signatures = signatures
            self.shares = shares
            self.secretDescription = descriptionName
            
            switch typeOfSharing {
            case .fullySplitted, .allInOne:
                self.simpleDistribution()
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)

            case .partially:
                self.partiallyDistribute()
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
    
    func distribtuteToDB(_ shares: [SecretDistributionDoc]?) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            guard let shares else {
                promise(.failure(MetaSecretErrorType.distributionDBError))
                return
            }
            let dictionary = shares.reduce(into: [String: [SecretDistributionDoc]]()) { result, object in
                let array = result[object.metaPassword?.metaPassword.id.name ?? "NoN"] ?? []
                result[object.metaPassword?.metaPassword.id.name ?? "NoN"] = array + [object]
            }
            
            for (descriptionName, shares) in dictionary {
                let filteredShares = shares.filter({$0.distributionType == .Split})
                let newSecret = Secret()
                newSecret.secretName = descriptionName
                newSecret.shares = List<String>()
                let mappedShares = filteredShares.map {self.jsonManager.jsonStringGeneration(from: $0)}
                for item in mappedShares {
                    newSecret.shares.append(item ?? "")
                }
                if self.dbManager.saveSecret(newSecret) {
                    promise(.success(()))
                } else {
                    promise(.failure(MetaSecretErrorType.commonError))
                }
            }
        }
    }
    
    func encryptShare(_ share: UserShareDto, _ receiverPubKey: Base64EncodedText) -> AeadCipherText? {
        guard let keyManager = userService.securityBox?.keyManager else {
//            alertManager.showCommonError(Constants.Errors.noMainUserError)
            return nil
        }
        
        let shareToEncode = ShareToEncrypt(senderKeyManager: keyManager, receiverPubKey: receiverPubKey, secret: jsonManager.jsonStringGeneration(from: share) ?? "")
        
        guard let encryptedShare = rustManager.encrypt(share: shareToEncode) else {
//            alertManager.showCommonError(Constants.Errors.encodeError)
            return nil
        }
        
        return encryptedShare
    }
}

private extension DistributionManager {
    func checkSharesResult(_ result: FindSharesResult) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            guard result.msgType == Constants.Common.ok,
                  let shares = result.data?.shares,
                  !(shares.isEmpty),
                  result.data?.userRequestType == .Split else {
                promise(.success(()))
                return
            }
            
            Logger().info("Check Shares Result: Distribute to DB")
            self.distribtuteToDB(result.data?.shares)
                .sink { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        Logger().error("Error: \(error.localizedDescription)")
                        promise(.failure(error))
                    }
                } receiveValue: {
                    Logger().info("*** NOTIFY *** Distribute to DB is ok. distributionService. type: CallBackType.Shares")
                    self.nc.post(name: NSNotification.Name(rawValue: "distributionService"), object: nil, userInfo: ["type": CallBackType.Shares])
                }.store(in: &self.cancellables)
        }
    }
    
    func checkForError() {
//        alertManager.showCommonError(MetaSecretErrorType.cantRestore.message())
        self.nc.post(name: NSNotification.Name(rawValue: "distributionService"), object: nil, userInfo: ["type": CallBackType.Failure])
    }
    
    func distributeClaimError() {
//        alertManager.showCommonError(MetaSecretErrorType.distribute.message())
    }
    
    @objc func fireSharesAndClaimRequestsTimer() {
        Logger().info("+++ Timer fired! +++ Find claims")
        findClaims()
        Logger().info("+++ Timer fired! +++ Find shares (.Split)")
        let _ = findShares(type: .Split)
    }
    
    //MARK: - CLAIMS ACTIONS
    @objc func fireClaimResponsesTimer() {
            findSharesClaim()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let text = (error as? MetaSecretErrorType)?.message() ?? error.localizedDescription
//                    self.alertManager.showCommonError(text)
                    self.nc.post(name: NSNotification.Name(rawValue: "distributionService"), object: nil, userInfo: ["type": CallBackType.Failure])
                }
            } receiveValue: {}.store(in: &self.cancellables)
    }
    
    func findSharesClaim() -> Future<Void, Error> {
        Future<Void, Error> { promise in
            self.shareService.findShares(type: .Recover)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { (result: FindSharesResult) in
                    self.commonResultHandler(result: result)
                        .sink { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        } receiveValue: {}.store(in: &self.cancellables)

                }.store(in: &self.cancellables)
        }
    }
    
    func handleClaimSharesResponse(_ result: FindSharesResult) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            guard self.isNeedToSearching else {
                promise(.success(()))
                return
            }
            
            guard result.msgType == Constants.Common.ok,
                  let shares = result.data?.shares, !shares.isEmpty,
                  shares.first?.distributionType == .Recover else {
                promise(.success(()))
                return
            }
            
            guard let share = shares.first,
                  share.distributionType == .Recover,
                  let keyManager = self.userService.securityBox?.keyManager,
                  let descriptionName = share.metaPassword?.metaPassword.id.name,
                  let secret = self.dbManager.readSecretBy(descriptionName: descriptionName),
                  let secretShareString = secret.shares.first,
                  let docOne: SecretDistributionDoc = try? self.jsonManager.objectGeneration(from: secretShareString)
            else {
                self.checkForError()
                promise(.failure(MetaSecretErrorType.shareSearchError))
                return
            }
            
            let model = RestoreModel(keyManager: keyManager, docOne: docOne, docTwo: share)
            let decriptedSecret = self.rustManager.restoreSecret(model: model)
            self.nc.post(name: NSNotification.Name(rawValue: "distributionService"), object: nil, userInfo: ["type": CallBackType.Claims(decriptedSecret, descriptionName)])
            promise(.success(()))
            return
        }
    }
    
    func commonShareChecking(_ result: FindSharesResult) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            
            guard result.msgType == Constants.Common.ok else {
                Logger().error("Error: \(MetaSecretErrorType.shareSearchError)")
                promise(.failure(MetaSecretErrorType.shareSearchError))
                return
            }
            
            guard let data = result.data else {
                promise(.success(()))
                return
            }
            
            let type = data.shares.isEmpty ? data.userRequestType : data.shares.first?.distributionType
            
            Logger().info("Checking Shares type:")
            switch type {
            case .Recover:
                Logger().info("Recover: stop monitoring claim response")
                self.stopMonitoringClaimResponses()
                if self.userService.mainVault?.signatures?.count == 3, data.shares.isEmpty {
                    promise(.success(()))
                    return
                }
                self.handleClaimSharesResponse(result)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            Logger().error("Error: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)

            case .Split:
                Logger().info("Split")
                if data.shares.isEmpty {
                    promise(.success(()))
                    return
                }
                Logger().info("Check Shares Result")
                self.checkSharesResult(result)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            Logger().error("Error: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    } receiveValue: {}.store(in: &self.cancellables)
            case .none:
                promise(.success(()))
                return
            }
        }
    }
    
    func askingForClaims(descriptionName: String) -> Future<Void, Error> {
        return Future { promise in
            
            guard let userSignature = self.userService.userSignature, let secret = self.dbManager.readSecretBy(descriptionName: descriptionName) else {
                promise(.failure(MetaSecretErrorType.commonError))
                return
            }
            
            let sharesArray = Array(secret.shares)
            
            self.isNeedToSearching = sharesArray.count != Constants.Common.neededMembersCount
            
            guard let shareString = sharesArray.first,
                  let shareObject: SecretDistributionDoc = try? self.jsonManager.objectGeneration(from: shareString),
                  let members = shareObject.metaPassword?.metaPassword.vault.signatures
            else {
                promise(.failure(MetaSecretErrorType.commonError))
                return
            }
            
            if sharesArray.count != 1,
               let securityBox = self.userService.securityBox,
               let shareString = sharesArray.last,
               let shareObjectLast: SecretDistributionDoc = try? self.jsonManager.objectGeneration(from: shareString)
            {
                self.stopMonitoringClaimResponses()
                let model = RestoreModel(keyManager: securityBox.keyManager, docOne: shareObject, docTwo: shareObjectLast)
                let decriptedSecret = self.rustManager.restoreSecret(model: model)
                self.nc.post(name: NSNotification.Name(rawValue: "distributionService"), object: nil, userInfo: ["type": CallBackType.Claims(decriptedSecret, descriptionName)])
                promise(.success(()))
                return
            }
            
            var futures = [Future<ClaimResult, Error>]()
            let otherDevices = members.filter({ $0.signature != userSignature.signature})
            let otherMembers = otherDevices.isEmpty ? [userSignature] : otherDevices
            
            for member in otherMembers {
                futures.append(self.shareService.requestClaim(provider: member, secret: secret))
            }
            
            Publishers.MergeMany(futures)
                .collect()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { results in
                    self.commonResultHandler(result: results)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }, receiveValue: {})
                        .store(in: &self.cancellables)
                })
                .store(in: &self.cancellables)
        }
    }
    
    func findClaims() {
        shareService.findClaims()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    Logger().error("Error: \(error.localizedDescription)")
                    print("Error: \(error)")
                }
            }, receiveValue: { result in
                self.commonResultHandler(result: result)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            Logger().error("Error: \(error.localizedDescription)")
                            print("Error: \(error)")
                        }
                    }, receiveValue: {})
                    .store(in: &self.cancellables)
            })
            .store(in: &self.cancellables)
    }
    
    func askConfirmation(claims: [PasswordRecoveryRequest]?) {
//        alertManager.showCommonAlert(AlertModel(title: Constants.Alert.needConfirmation,
//                                                message: Constants.Alert.confirmationText,
//                                                okHandler: { [weak self] in
//            self?.distributeClaimsToRestore(claims)
//        }, cancelHandler: {
//            return
//        }))
    }
    
    func distributeClaimsToRestore(_ claims: [PasswordRecoveryRequest]?) {
        guard let claims else {
            distributeClaimError()
            return
        }

        #warning("Now we supose we have only one claim, but in future we could have a few")
        for claim in claims {
            var newEncryptedshare: AeadCipherText? = nil
            var secretDoc: SecretDistributionDoc? = nil

            guard let name = claim.id.name,
                  let secret = dbManager.readSecretBy(descriptionName: name),
                  let encryptedShare = secret.shares.first else {
                distributeClaimError()
                return
            }
            
            secretDoc = try? jsonManager.objectGeneration(from: encryptedShare)
            let chanel = secretDoc?.secretMessage?.encryptedText.authData.channel
            
            if claim.consumer.transportPublicKey.base64Text == chanel?.receiver.base64Text ||
                claim.consumer.transportPublicKey.base64Text == chanel?.sender.base64Text {
                newEncryptedshare = secretDoc?.secretMessage?.encryptedText
            } else {
                guard let secretDoc,
                      let keyManager = userService.securityBox?.keyManager,
                      let userShareDto = rustManager.decrypt(model: DecryptModel(keyManager: keyManager, doc: secretDoc)) else {
                    distributeClaimError()
                    return
                }
                
                newEncryptedshare = rustManager.encrypt(share: ShareToEncrypt(senderKeyManager: keyManager, receiverPubKey: claim.consumer.transportPublicKey, secret: userShareDto))
            }
            
            guard let encryptedShare = newEncryptedshare else {
                distributeClaimError()
                return
            }

            let _ = distribution(encodedShare: encryptedShare, receiver: claim.consumer, descriptionName: name, type: .Recover)
        }
    }
    
    //MARK: - VAULTS ACTIONS
    @objc func fireVaultsTimer() {
        Logger().info("+++ Timer fired! +++ Get vault")
        let _ = getVault()
    }
    
    //MARK: - DISTRIBUTE ACTIONS
    func distribution(encodedShare: AeadCipherText, receiver: UserSignature, descriptionName: String, type: SecretDistributionType) -> Future<DistributeResult, Error> {
        return shareService.distribute(encodedShare: encodedShare, receiver: receiver, descriptionName: descriptionName, type: type)
    }
    
    func handleDistributionResult(_ result: DistributeResult) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            guard result.msgType == Constants.Common.ok else {
                Logger().error("Error: \(MetaSecretErrorType.distribute)")
                promise(.failure(MetaSecretErrorType.distribute))
                return
            }
            Logger().info("Success")
            promise(.success(()))
        }
    }
}

private extension DistributionManager {
    //MARK: - DISTRIBUTIONS FLOWS
    func simpleDistribution() -> Future<Void, Error> {
            Future<Void, Error> { promise in
                self.distributeSharesToMembers(self.shares, signatures: self.signatures, descriptionName: self.secretDescription)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }, receiveValue: {})
                    .store(in: &self.cancellables)
            }
        }
    
    func partiallyDistribute() -> Future<Void, Error> {
            Future<Void, Error> { promise in
                guard let lastShare = self.shares.last else {
                    promise(.failure(MetaSecretErrorType.commonError))
                    return
                }
                self.shares.append(lastShare)
                self.signatures.append(contentsOf: self.signatures)

                self.simpleDistribution()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }, receiveValue: {})
                    .store(in: &self.cancellables)
            }
        }
}

private extension DistributionManager {
    func commonResultHandler<T>(result: T) -> Future<Void, Error> {
            Future<Void, Error> { promise in
                Logger().info("Handle result")
                
                switch result {
                case let distributeResult as DistributeResult:
                    Logger().info("Handle Distribute Result")
                    self.handleDistributionResult(distributeResult)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(let error):
                                Logger().error("Error: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: {})
                        .store(in: &self.cancellables)

                case let getVaultResult as GetVaultResult:
                    Logger().info("Handle GetVault Result")
                    self.userService.mainVault = getVaultResult.data?.vault
                    Logger().info("*** NOTIFY *** distributionService. type: CallBackType.Devices")
                    DispatchQueue.main.async {
                        self.nc.post(name: NSNotification.Name(rawValue: "distributionService"), object: nil, userInfo: ["type": CallBackType.Devices])
                    }
                    promise(.success(()))

                case let findSharesResult as FindSharesResult:
                    Logger().info("Handle FindShares Result")
                    self.commonShareChecking(findSharesResult)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                promise(.success(()))
                            case .failure(let error):
                                Logger().error("Error: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: {})
                        .store(in: &self.cancellables)

                case let findClaimsResult as FindClaimsResult:
                    Logger().info("Handle FindClaims Result")
                    if findClaimsResult.msgType == Constants.Common.ok, !(findClaimsResult.data?.isEmpty ?? true) {
                        self.askConfirmation(claims: findClaimsResult.data)
                    }
                    promise(.success(()))

                case is [DistributeResult], is ClaimResult:
                    Logger().info("Handle Claim Result")
                    promise(.success(()))

                default:
                    Logger().info("Handle Result")
                    promise(.success(()))
                }
            }
        }
}

enum CallBackType {
    case Shares
    case Devices
    case Claims(String?, String?)
    case Failure
}


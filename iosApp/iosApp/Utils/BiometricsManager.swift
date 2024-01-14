//
//  BiometricsManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 23.10.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import LocalAuthentication
import Combine
import OSLog

protocol BiometricsManagerProtocol {
    func canEvaluate() -> Bool
    func evaluate() -> AnyPublisher<(Bool, BiometricError?), Never>
}

final class BiometricsManager: NSObject, BiometricsManagerProtocol {
    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedReason: String
    private let logger = Logger()
    private var error: NSError?
    
    override init() {
        logger.info("BiometricsManager -- init")
        self.policy = .deviceOwnerAuthentication
        self.localizedReason = Constants.Alert.biometricalReason
        context.localizedFallbackTitle = Constants.BiometricError.enterAppPass
        context.localizedCancelTitle = nil
    }
    
    func canEvaluate() -> Bool {
        logger.info("BiometricsManager -- canEvaluate()")
        guard context.canEvaluatePolicy(policy, error: &error) else {
            let _ = biometricType(for: context.biometryType)
            guard error == nil else {
                logger.info("BiometricsManager -- canEvaluate error")
                return false
            }
            logger.info("BiometricsManager -- canEvaluate OK")
            return true
        }
        return true
    }
    
    func evaluate() -> AnyPublisher<(Bool, BiometricError?), Never> {
        logger.info("BiometricsManager -- evaluate")
        return Future<(Bool, BiometricError?), Never> { [weak self] promise in
            guard let self else {
                promise(.success((false, nil)))
                return
            }
            
            self.context.evaluatePolicy(policy, localizedReason: self.localizedReason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        promise(.success((true, nil)))
                    } else {
                        if let error = error as NSError? {
                            promise(.success((false, self.biometricError(from: error))))
                        } else {
                            promise(.success((false, nil)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func biometricType(for type: LABiometryType) -> BiometricType {
        switch type {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        case .opticID:
            return .unknown
        @unknown default:
            return .unknown
        }
    }
    
    fileprivate func biometricError(from nsError: NSError) -> BiometricError {
        let error: BiometricError
        
        switch nsError {
        case LAError.authenticationFailed:
            error = .authenticationFailed
        case LAError.userCancel:
            error = .userCancel
        case LAError.userFallback:
            error = .userFallback
        case LAError.biometryNotAvailable:
            error = .biometryNotAvailable
        case LAError.biometryNotEnrolled:
            error = .biometryNotEnrolled
        case LAError.biometryLockout:
            error = .biometryLockout
        default:
            error = .unknown
        }
        
        return error
    }
}

enum BiometricError: LocalizedError {
    case authenticationFailed
    case userCancel
    case userFallback
    case biometryNotAvailable
    case biometryNotEnrolled
    case biometryLockout
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .authenticationFailed: return Constants.BiometricError.authenticationFailed
        case .userCancel: return Constants.BiometricError.userCancel
        case .userFallback: return Constants.BiometricError.userFallback
        case .biometryNotAvailable: return Constants.BiometricError.biometryNotAvailable
        case .biometryNotEnrolled: return Constants.BiometricError.biometryNotEnrolled
        case .biometryLockout: return Constants.BiometricError.biometryLockout
        case .unknown: return Constants.BiometricError.unknown
        }
    }
}

enum BiometricType {
    case none
    case touchID
    case faceID
    case unknown
}

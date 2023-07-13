//
//  AddSecretViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 27.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

class AddSecretViewModel: ObservableObject {
    @Service private var contentManager: ContentManagerProtocol
    @Published private(set) var errors: [AddSecretErrorType] = [AddSecretErrorType]()
    @Published var secretName: String?
    @Published var secret: String?
    
    // MARK: Methods
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

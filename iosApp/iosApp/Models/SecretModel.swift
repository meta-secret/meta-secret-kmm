//
//  SecretModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class SecretModel: CommonItemModel {
    var type: ItemType
    private(set) var strenghtType: StrenghtType
    private(set) var description: String
    private(set) var secret: String
    
    init(description: String, secret: String, strenghtType: StrenghtType) {
        self.type = .secrets
        self.strenghtType = strenghtType
        self.description = description
        self.secret = secret
    }
}

enum StrenghtType: Int {
    case strong
    case weak
    case maximum
    
    var title: String {
        switch self {
        case .strong:
            return Constants.Secrets.strong
        case .weak:
            return Constants.Secrets.weak
        case .maximum:
            return Constants.Secrets.maximum
        }
    }
    
    var image: String {
        switch self {
        case .strong:
            return AppImages.Secrets.strongProtectionImage
        case .weak:
            return AppImages.Secrets.weekProtectionImage
        case .maximum:
            return AppImages.Secrets.maxProtectionImage
        }
    }
}

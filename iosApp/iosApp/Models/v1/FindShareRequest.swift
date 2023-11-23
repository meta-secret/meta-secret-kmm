//
//  FindShareRequest.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 22.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

final class FindSharesRequest: BaseModel {
    var userRequestType: SecretDistributionType
    var userSignature: UserSignature
    
    init(userRequestType: SecretDistributionType, userSignature: UserSignature) {
        self.userRequestType = userRequestType
        self.userSignature = userSignature
    }
}

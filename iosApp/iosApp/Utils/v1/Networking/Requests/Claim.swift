//
//  Claim.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

final class Claim: HTTPRequest {
    var ignorable: Bool { return true }
    var params: String
    var path: String { return "claimForPasswordRecovery" }
    
    init(_ params: String) {
        self.params = params
    }
}

struct ClaimResult: Codable {
    var msgType: String?
    var data: String?
    var error: String?
}

enum StatusResponse: String, Codable {
    case ok = "Ok"
    case err = "Error"
}

final class PasswordRecoveryRequest: BaseModel {
    let id: MetaPasswordId
    let consumer: UserSignature
    let provider: UserSignature
    
    init(id: MetaPasswordId, consumer: UserSignature, provider: UserSignature) {
        self.id = id
        self.consumer = consumer
        self.provider = provider
    }
}

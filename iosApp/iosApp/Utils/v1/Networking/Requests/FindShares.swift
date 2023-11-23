//
//  FindShares.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

final class FindShares: HTTPRequest {
    var ignorable: Bool { return true }
    var params: String
    var path: String { return "findShares" }
    
    init(_ params: String) {
        self.params = params
    }
}

struct FindSharesResult: Codable {
    var msgType: String
    var data: FindSharesResponse?
    var error: String?
}

struct FindSharesResponse: Codable {
    var userRequestType: SecretDistributionType
    var shares: [SecretDistributionDoc]
}

struct SecretDistributionDoc: Codable {
    var distributionType: SecretDistributionType?
    var metaPassword: MetaPasswordRequest?
    var secretMessage: EncryptedMessage?
}


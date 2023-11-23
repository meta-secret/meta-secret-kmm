//
//  FindClaim.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

final class FindClaims: HTTPRequest {
    var ignorable: Bool { return true }
    var params: String
    var path: String { return "findPasswordRecoveryClaims" }
    
    init(_ params: String) {
        self.params = params
    }
}

struct FindClaimsResult: Codable {
    var msgType: String?
    var data: [PasswordRecoveryRequest]?
    var error: String?
}

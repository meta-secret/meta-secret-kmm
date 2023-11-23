//
//  Secret.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import RealmSwift

final class Secret: Object {

    @objc dynamic var secretName = ""
    var shares = List<String>()
    
    override static func primaryKey() -> String? {
        return "secretName"
    }
}

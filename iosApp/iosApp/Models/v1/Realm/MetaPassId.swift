//
//  MetaPassId.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import RealmSwift

final class MetaPassId: Object {

    @objc dynamic var secretName: String = ""
    @objc dynamic var metaPassId: String = ""
    
    override static func primaryKey() -> String? {
        return "secretName"
    }
}


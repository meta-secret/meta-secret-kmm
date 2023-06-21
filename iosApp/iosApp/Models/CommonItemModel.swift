//
//  CommonItemModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

protocol CommonItemModel: Identifiable {
    var type: ItemType { get set }
    var id: UUID { get }
}

extension CommonItemModel {
    var id: UUID {
        return UUID()
    }
}

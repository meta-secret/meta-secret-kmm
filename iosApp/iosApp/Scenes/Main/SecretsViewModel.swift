//
//  SecretsViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 14.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class SecretsViewModel: CommonViewModel {
    override init() {
        super.init()
        getItems()
    }
}

private extension SecretsViewModel {
    func getItems() {
        getContent(of: .secrets)
    }
}

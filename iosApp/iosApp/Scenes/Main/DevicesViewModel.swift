//
//  DevicesViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class DevicesViewModel: CommonViewModel {
    override init() {
        super.init()
        getItems()
    }
    
    var deviceAdd = ""
}

private extension DevicesViewModel {
    func getItems() {
        getContent(of: .device)
    }
}

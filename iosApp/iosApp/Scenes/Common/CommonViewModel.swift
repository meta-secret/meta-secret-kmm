//
//  CommonViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class CommonViewModel {
    @Service private var contentManager: ContentManagerProtocol
    private(set) var items: [CommonItemModel] = [CommonItemModel]()
    
    func getContent(of type: ItemType) {
        items = contentManager.getContentItems(by: type)
    }
}

private extension CommonViewModel {
    
}

//
//  CommonViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import Combine
import OSLog

class CommonViewModel: ObservableObject {
    @Service private var contentManager: ContentManagerProtocol
    
    @Published var isLoading = false
    @Published var isError = false
    @Published var isToReload: Bool = false
    @Published var textError: String?
    @Published var showPopup: Bool = false
    
    var popUpTitle = ""
    var popUpMessage = ""
    var okHandler: () -> () = {}
    var cancelHandler: () -> () = {}
    
    private(set) var items: [any CommonItemModel] = [any CommonItemModel]()
    
    var devicesCount: Int {
        contentManager.getContentItems(by: .device).count
    }
    
    
    func getContent(of type: ItemType) {
        items = contentManager.getContentItems(by: type)
        Logger().info("There is \(self.items.count) item(s) of type: \(type.name())")
    }
    
    func errorHandling(_ completion: Subscribers.Completion<Error>, error: MetaSecretErrorType) {
        switch completion {
        case .finished:
            DispatchQueue.main.async {
                self.isLoading = false
            }
            break
        case .failure(_):
            DispatchQueue.main.async {
                Logger().error("Error: \(error.message())")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.textError = error.message()
                    self.isError = true
                }
            }
        }
    }
    
    func showErrorAlert(_ error: String) {
        self.popUpTitle = Constants.Errors.error
        self.popUpMessage = error
        self.okHandler = {
            self.showPopup = false
        }
        self.showPopup = true
    }
}

private extension CommonViewModel {
    
}

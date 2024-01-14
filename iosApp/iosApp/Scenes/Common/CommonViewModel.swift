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

class CommonViewModel: ObservableObject, LoggerManager {
    @Service private var contentManager: ContentManagerProtocol
    
    @Published var isLoading = false // To show activity loader
    @Published var isError = false // To show error in text field
    @Published var textError: String? // Error message in text field
    @Published var isToReload: Bool = false // To reload view (Does not work)
    @Published var showPopup: Bool = false // To show popUp
    
    var popUpTitle = "" // Popup title
    var popUpMessage = "" // Popup message
    var okHandler: () -> () = {} // Popup OK handler
    var cancelHandler: () -> () = {} // Popup CANCEL handler
    
    private(set) var items: [any CommonItemModel] = [any CommonItemModel]()
    
    var devicesCount: Int {
        log("Get devices count.")
        return contentManager.getContentItems(by: .device).count
    }
    
    var secretsCount: Int {
        log("Get secrets count.")
        return contentManager.getContentItems(by: .secrets).count
    }
    
    func onAppear() {}
    
    func getContent(of type: ItemType) {
        log("Get content by \(type.name()).")
        items = contentManager.getContentItems(by: type)
        Logger().info("There is \(self.items.count) item(s) of type: \(type.name())")
        log("There is \(self.items.count) item(s) of type: \(type.name())")
        DispatchQueue.main.async {
            self.log("Need to reload view after items change.")
            self.isToReload.toggle()
        }
    }
    
    func errorHandlingTextField(_ completion: Subscribers.Completion<Error>, error: MetaSecretErrorType) {
        switch completion {
        case .finished:
            DispatchQueue.main.async {
                self.isLoading = false
            }
        case .failure(_):
            DispatchQueue.main.async {
                self.log("Error: \(error.message())", isError: true)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.textError = error.message()
                    self.isError = true
                }
            }
        }
    }
    
    func errorHandling(_ completion: Subscribers.Completion<Error>, error: MetaSecretErrorType) {
        switch completion {
        case .finished:
            DispatchQueue.main.async {
                self.isLoading = false
            }
        case .failure(_):
            DispatchQueue.main.async {
                self.log("Error: \(error.message())", isError: true)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.textError = error.message()
                    self.isError = true
                }
            }
        }
    }
    
    func errorHandlingAlert(_ completion: Subscribers.Completion<Error>, error: MetaSecretErrorType) {
        switch completion {
        case .finished:
            DispatchQueue.main.async {
                self.isLoading = false
            }
        case .failure(_):
            DispatchQueue.main.async {
                self.log("Error: \(error.message())", isError: true)
                self.popUpTitle = Constants.Errors.error
                self.popUpMessage = error.message()
                self.okHandler = {
                    self.showPopup = false
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.showPopup = true
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

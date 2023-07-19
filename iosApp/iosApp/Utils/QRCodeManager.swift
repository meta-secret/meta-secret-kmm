//
//  QRCodeManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

protocol QRCodeManagerProtocol {
    func getQRcodeContent() -> String
}

class QRCodeManager: QRCodeManagerProtocol {
    func getQRcodeContent() -> String {
        #warning("Need to implement Device Manager and Secrets Manager")
        return Greeting().greet()
        //return getQRLink()
        //return Constants.Common.appStoreLink
    }
}

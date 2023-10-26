//
//  QRCodeManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared

protocol QRCodeManagerProtocol {
    func getQRcodeContent() -> String
}

class QRCodeManager: QRCodeManagerProtocol {
    func getQRcodeContent() -> String {
        return Greeting().getAppUrl()
    }
}

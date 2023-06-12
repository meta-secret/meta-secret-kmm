//
//  SignInViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 11.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

class SignInViewModel {
    var titleText: String {
        return Constants.LetsStart.letsStart
    }
    
    var descriptionText: String {
        return Constants.LetsStart.chooseName
    }
    
    var placeholder: String {
        return Constants.LetsStart.chooseNamePlaceHolder
    }
    
    var scanQrText: String {
        return Constants.LetsStart.scanQR
    }
    
    var nextButtonText: String {
        return Constants.LetsStart.moveNext
    }
}

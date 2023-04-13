//
//  TextStyles.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

enum CustomTextStyle {
    case SplashTitle
    
    var size: Int {
        switch self {
            case .SplashTitle:         return 48
        }
    }
    
//    var name: CustomFont {
//        switch self {
//            case .body:                             return .medium
//        }
//    }
}

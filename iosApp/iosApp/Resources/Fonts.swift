//
//  Fonts.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 18.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import UIKit

enum FontStyle {
    case title
    case subtitle
    case chapter
    case button
    case header
    case normalMain
    case normal
    case mini
    case miniMedium
    case h2
    case h3
    
    var font: UIFont {
        return UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    private var fontSize: CGFloat {
        switch self {
        case .title:
            return 140
        case .subtitle:
            return 52
        case .chapter:
            return 28
        case .header:
            return 32
        case .button:
            return 16
        case .normalMain:
            return 15
        case .normal:
            return 14
        case .mini:
            return 11
        case .miniMedium:
            return 11
        case .h2:
            return 18
        case .h3:
            return 16
        }
    }
    
    private var fontName: String {
        switch self {
        case .title:
            return "manrope-extrabold"
        case .subtitle:
            return "manrope-bold"
        case .chapter:
            return "manrope-bold"
        case .header:
            return "manrope-bold"
        case .button:
            return "manrope-semibold"
        case .normalMain:
            return "Manrope-Regular"
        case .normal:
            return "manrope-regular"
        case .mini:
            return "manrope-regular"
        case .miniMedium:
            return "manrope-medium"
        case .h2:
            return "manrope-bold"
        case .h3:
            return "manrope-bold"
        
        }
    }
}

/*
 case heavy = "manrope-extrabold"
 case bold = "manrope-bold"
 case medium = "manrope-medium"
 case regular = "manrope-regular"
 case light = "manrope-light"
 case semibold = "manrope-semibold"
 */

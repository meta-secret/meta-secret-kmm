//
//  Fonts.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 18.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

enum FontStyle {
    case title
    case subtitle
    case chapter
    case button
    case header
    case normalInput
    case normalSemi
    case normalMain
    case normal
    case normalSmall
    case mini
    case miniMedium
    case h1
    case h2
    case h3
    case h4
    case error
    
    var font: Font {
        return .custom(fontName, size: fontSize)
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
        case .normalInput:
            return 16
        case .normalSemi:
            return 16
        case .normalMain:
            return 15
        case .normal:
            return 14
        case .normalSmall:
            return 13
        case .mini:
            return 11
        case .miniMedium:
            return 11
        case .h1:
            return 24
        case .h2:
            return 20
        case .h3:
            return 18
        case .h4:
            return 16
        case .error:
            return 13
        }
    }
    
    private var fontName: String {
        switch self {
        case .title:
            return "Manrope-Extrabold"
        case .subtitle:
            return "Manrope-Bold"
        case .chapter:
            return "Manrope-Bold"
        case .header:
            return "Manrope-Bold"
        case .button:
            return "Manrope-Semibold"
        case .normalInput:
            return "Manrope-Regular"
        case .normalSemi:
            return "Manrope-Semibold"
        case .normalMain:
            return "Manrope-Regular"
        case .normal:
            return "Manrope-Regular"
        case .normalSmall:
            return "Manrope-Regular"
        case .mini:
            return "Manrope-Regular"
        case .miniMedium:
            return "Manrope-Medium"
        case .h1:
            return "Manrope-Bold"
        case .h2:
            return "Manrope-Bold"
        case .h3:
            return "Manrope-Bold"
        case .h4:
            return "Manrope-Bold"
        case .error:
            return "Manrope-Regular"
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

//
//  PageControllViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 08.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class PageControllViewModel {
    private(set) var pages: Int
    private(set) var circleDiameter: CGFloat
    private(set) var circleMargin: CGFloat
    
    init(pages: Int = 1, circleDiameter: CGFloat = 8, circleMargin: CGFloat = 8) {
        self.pages = pages
        self.circleDiameter = circleDiameter
        self.circleMargin = circleMargin
    }
}

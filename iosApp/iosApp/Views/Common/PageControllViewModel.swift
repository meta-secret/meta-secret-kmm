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
    
    private(set) var currentPosition: CGFloat
    
    init(pages: Int = 1, circleDiameter: CGFloat = 8, circleMargin: CGFloat = 8) {
        self.pages = pages
        self.circleDiameter = circleDiameter
        self.circleMargin = circleMargin
        
        let stackWidth = circleDiameter * CGFloat(pages) + circleMargin * CGFloat(pages - 1)
        let halfStackWidth = stackWidth / 2
        let iniPosition = -halfStackWidth + (circleDiameter / 2)
        let distanceToNextPoint = circleDiameter + circleMargin

        

            private var currentPosition: CGFloat {
                // Get the first circle position
                let stackWidth = circleDiameter * CGFloat(pages) + circleMargin * CGFloat(pages - 1)
                let halfStackWidth = stackWidth / 2
                let iniPosition = -halfStackWidth + circleRadius

                // Calculate the distance to get the next circle
                let distanceToNextPoint = circleDiameter + circleMargin

                // Use the pageIndex to get the current position
                return iniPosition + (pageIndex * distanceToNextPoint)
            }
    }
}

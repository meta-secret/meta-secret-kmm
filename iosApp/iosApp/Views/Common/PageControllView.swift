//
//  PageControllView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 08.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct PageControllView: View {
        @Binding var selectedPage: Int

        var pages: Int
        var circleDiameter: CGFloat
        var circleMargin: CGFloat

        private var circleRadius: CGFloat { circleDiameter / 2}
        private var pageIndex: CGFloat { CGFloat(selectedPage - 1) }

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

        var body: some View {
            ZStack {
                // Total number of pages
                HStack(spacing: circleMargin) {
                    ForEach(0 ..< pages) { _ in
                        Circle()
                            .foregroundColor(AppColors.white50)
                            .frame(width: circleDiameter, height: circleDiameter)
                    }
                }

                Circle()
                    .foregroundColor(AppColors.actionLinkBlue)
                    .frame(width: circleDiameter, height: circleDiameter)
                    .offset(x: currentPosition)
//                    .animation(.linear(duration: 0.3))
            }
        }
    }

struct PageControlView_Previews: PreviewProvider {
    static var previews: some View {
        PageControllView(selectedPage: .constant(0), pages: 5, circleDiameter: 8, circleMargin: 8)
    }
}

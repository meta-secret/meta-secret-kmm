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
            let stackWidth = circleDiameter * CGFloat(pages) + circleMargin * CGFloat(pages - 1)
            let halfStackWidth = stackWidth / 2
            let iniPosition = -halfStackWidth + circleRadius
            let distanceToNextPoint = circleDiameter + circleMargin
            return iniPosition + (pageIndex * distanceToNextPoint)
        }

        var body: some View {
            ZStack {
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
                    .animation(.linear(duration: selectedPage > 1 ? 0.3 : 0.0))
            }
        }
    }

struct PageControlView_Previews: PreviewProvider {
    static var previews: some View {
        PageControllView(selectedPage: .constant(0), pages: 5, circleDiameter: 8, circleMargin: 8)
    }
}

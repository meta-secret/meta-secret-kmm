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
    @State var viewModel: PageControllViewModel
    
    var body: some View {
        ZStack {
            HStack(spacing: viewModel.circleMargin) {
                ForEach(0 ..< viewModel.pages) { _ in
                    Circle()
                        .foregroundColor(AppColors.white50)
                        .frame(width: viewModel.circleDiameter, height: viewModel.circleDiameter)
                }
            }
            
            Circle()
                .foregroundColor(AppColors.actionLinkBlue)
                .frame(width: viewModel.circleDiameter, height: viewModel.circleDiameter)
        }
    }
}

struct PageControlView_Previews: PreviewProvider {
    static var previews: some View {
        PageControllView(selectedPage: .constant(5), viewModel: PageControllViewModel(pages: 5))
    }
}

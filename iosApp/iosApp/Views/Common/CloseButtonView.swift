//
//  CloseButtonView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct CloseButtonView: View {
    let action: () -> Void
    
    private enum Config {
        static let cornerRadius: CGFloat = 8.0
    }
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(AppColors.white10)
                    .frame(width: 24.0, height: 24.0)
                Image(AppImages.Common.closeIco)
            }        }
        .frame(width: 24, height: 24)
    }
}

struct CloseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            CloseButtonView(action: {})
        }
        
    }
}

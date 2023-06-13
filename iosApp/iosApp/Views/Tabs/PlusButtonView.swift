//
//  PlusButtonView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct PlusButtonView: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .strokeBorder(AppColors.white15, lineWidth: 6)
                    .background(Circle().foregroundColor(AppColors.actionBlue))
                    .frame(width: 80.0, height: 80.0)
                Image(AppImages.bigPlusImage)
                
            }
        }
        .frame(width: 80.0, height: 80.0)
    }
}

struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView(action: {})
    }
}

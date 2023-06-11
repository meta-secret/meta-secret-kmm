//
//  NextButtonView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 12.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct NextButtonView: View {
    var title: String
    
    private enum Config {
        static let cornerRadius: CGFloat = 8.0
    }
    
    var body: some View {
        Button(action: {
            
        }) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 48)
                .foregroundColor(AppColors.white)
                .background(AppColors.actionBlue)
                .font(FontStyle.button.font)
                .cornerRadius(Config.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: Config.cornerRadius)
                        .stroke(AppColors.white5, lineWidth: 1)
                )
        }
        .frame(height: 48)
    }
}

struct NextButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NextButtonView(title: "Next")
    }
}

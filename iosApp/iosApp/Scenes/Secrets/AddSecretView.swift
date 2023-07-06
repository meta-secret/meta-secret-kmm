//
//  AddSecretView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 27.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct AddSecretView: View {
    private enum Config {
        static let cornerRadius: CGFloat = 16.0
        static let height: CGFloat = 294.0
    }
    
    var body: some View {
        VStack {
            ZStack {
                AppColors.blackPopUps.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        CloseButtonView(action: {})
                    }
                    .padding(.horizontal, 10.0)
                    HStack {
                        Text(Constants.Secrets.addSecret)
                            .font(FontStyle.h1.font)
                            .foregroundColor(AppColors.white)
                        Spacer()
                    }
                    .padding(.horizontal, 16.0)
                    HStack {
                        TipTextfieldView(placeHolder: Constants.Secrets.secretName, error: .constant(nil))
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 16.0)
                    HStack {
                        TipTextfieldView(placeHolder: Constants.Secrets.secret, error: .constant(nil))
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 16.0)
                    
                    HStack {
                        ActionBlueButton(title: Constants.Secrets.addSecret, action: {})
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 16.0)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct AddSecretView_Previews: PreviewProvider {
    static var previews: some View {
        AddSecretView()
    }
}

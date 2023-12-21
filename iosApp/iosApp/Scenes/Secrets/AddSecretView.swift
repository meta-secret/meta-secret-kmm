//
//  AddSecretView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 27.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import Combine

struct AddSecretView: View {
    private enum Config {
        static let cornerRadius: CGFloat = 16.0
        static let sideOffset: CGFloat = 16.0
        static let closeSideOffset: CGFloat = 10.0
        static let vSpacerHeight: CGFloat = 20.0
        static let bottomSpacerHeight: CGFloat = 30.0
    }
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: AddSecretViewModel = AddSecretViewModel()
    @State var saveError: String? = Constants.Common.enterValue
    
    var body: some View {
        VStack {
            ZStack {
                //BG
                AppColors.blackPopUps.ignoresSafeArea()
                
                //Main container
                VStack {
                    //Close button
                    VStack {
                        Spacer()
                            .frame(height: Config.closeSideOffset)
                        HStack {
                            Spacer()
                            CloseButtonView(action: {dismiss()})
                            Spacer()
                                .frame(width: Config.closeSideOffset)
                        }
                    }
                    
                    //Title
                    VStack {
                        HStack {
                            Text(Constants.Secrets.addSecret)
                                .font(FontStyle.h1.font)
                                .foregroundColor(AppColors.white)
                            Spacer()
                        }
                        .padding(.horizontal, Config.sideOffset)
                        Spacer()
                            .frame(height: Config.vSpacerHeight)
                    }
                    
                    // Secret name Text field
                    VStack {
                        HStack {
                            TipTextfieldView(textValue: $viewModel.secretName, placeHolder: Constants.Secrets.secretName, error: viewModel.getError(by: .secretName) ? $saveError : .constant(nil))
                        }
                        .padding(.horizontal, Config.sideOffset)
                        Spacer()
                            .frame(height: Config.vSpacerHeight)
                    }
                    
                    // Secret Text field
                    VStack {
                        HStack {
                            TipTextfieldView(textValue: $viewModel.secret, placeHolder: Constants.Secrets.secret, error: viewModel.getError(by: .secret) ? $saveError : .constant(nil))
                        }
                        .padding(.horizontal, Config.sideOffset)
                        Spacer()
                            .frame(height: Config.vSpacerHeight)
                    }
                    
                    //Button
                    VStack {
                        HStack {
                            ActionBlueButton(title: Constants.Secrets.addSecret, action: {
                                viewModel.setErrors()
                                if viewModel.errors.isEmpty {
                                    viewModel.saveSecret()
                                    dismiss()
                                }
                            })
                        }
                        .padding(.horizontal, Config.sideOffset)
                        Spacer()
                    }
                }
                .keyboardAdaptive()
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

enum ModeType {
    case readOnly
    case edit
    case distribute
}

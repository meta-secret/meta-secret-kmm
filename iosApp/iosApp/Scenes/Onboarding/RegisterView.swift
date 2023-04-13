//
//  RegisterView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 06.04.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel: OnboardingContnetViewModel
    @State private var isPushed = false
    
    private enum Config {
        static let verticalSpacing: CGFloat = 28.0
        static let cornerRadius: CGFloat = 10.0
        static let sideOffset: CGFloat = 16.0
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    // Subtitle
                    Spacer()
                        .frame(height: Config.verticalSpacing * 2)
                    HStack {
                        Text(viewModel.pageType.subtitle)
                            .font(.custom(Avenir.medium.rawValue, size: AvenirSize.t2.rawValue))
                            .foregroundColor(AppColors.mainDarkGray)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Main title
                    HStack {
                        Text(viewModel.pageType.title)
                            .font(.custom(Avenir.heavy.rawValue, size: AvenirSize.h3.rawValue))
                            .foregroundColor(AppColors.mainBlack)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 1)
                    
                    // Text field
                    HStack {
                        Spacer()
                        ZStack(alignment: .leading) {
                            if viewModel.vaultName.isEmpty {
                                Text(viewModel.pageType.placeHolder)
                                    .font(.custom(Avenir.medium.rawValue, size: AvenirSize.t2.rawValue))
                                    .foregroundColor(AppColors.mainDarkGray)
                                    .padding(.horizontal)
                            }
                            TextField("", text: $viewModel.vaultName)
                                .textFieldStyle(.plain)
                                .padding(.horizontal)
                                .foregroundColor(AppColors.mainBlack)
                                .font(.custom(Avenir.medium.rawValue, size: AvenirSize.t2.rawValue))
                                .accentColor(AppColors.mainDarkGray)
                                .textFieldStyle(.roundedBorder)
                        }
                        .frame(height: 48.0)
                        .background(AppColors.mainWhite)
                        .cornerRadius(10.0)
                    }
                    .padding(.leading, 8.0)
                    .padding(.trailing, 16.0)
                    .padding(.bottom)
                    
                    // Image
                    Image(viewModel.pageType.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    // Description
                    Text(viewModel.pageType.description)
                        .font(.custom(Avenir.medium.rawValue, size: AvenirSize.t1.rawValue))
                        .foregroundColor(AppColors.mainBlack)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    // Buttons
                    NavigationLink(destination: WelcomeDBView(viewModel: viewModel), isActive: $isPushed, label: {
                        Text(viewModel.pageType.buttonTitle)
                            .frame(width: geo.size.width - Config.sideOffset * 2, height: 48)
                            .font(.custom(Avenir.bold.rawValue, size: AvenirSize.t2.rawValue))
                            .foregroundColor(viewModel.vaultName.isEmpty ? AppColors.mainGray : AppColors.mainBlack)
                            .background(viewModel.vaultName.isEmpty ? AppColors.mainDarkGray : AppColors.mainOrange)
                            .cornerRadius(Config.cornerRadius)
                        
                    })
                    .disabled(viewModel.vaultName.isEmpty)
                    .onChange(of: isPushed, perform: { _ in
                        viewModel.pageType = .welcomeDB
                    })
                    Spacer()
                        .frame(height: Config.verticalSpacing)
                }
            }
            .background(AppColors.mainCreame).ignoresSafeArea()
            .onTapGesture(perform: hideKeyboard)
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: OnboardingContnetViewModel(pageType: .register))
    }
}

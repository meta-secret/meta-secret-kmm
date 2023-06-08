//
//  OnboardingContainerView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import CodeScanner

struct OnboardingContainerView: View {
    @State var viewModel: OnboardingContnetViewModel
    
    private enum Config {
        static let verticalSpacing: CGFloat = 28.0
        static let cornerRadius: CGFloat = 8.0
        static let sideOffset: CGFloat = 16.0
        static let verticalPageControllOffset: CGFloat = 6.0
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                
                ZStack {
                    AppColors.blackBg.ignoresSafeArea()
                    Image(AppImages.mainBg)
                        .resizable()
                        .ignoresSafeArea()
                    VStack {
                        Spacer().frame(height: Config.verticalPageControllOffset)
                        HStack {
                            Text("\(viewModel.pageType.currentPage)/\(viewModel.pageType.totalSteps)")
                                .font(Font(FontStyle.normalMain.font))
                                .foregroundColor(AppColors.white75)
                            Spacer()
                            PageControllView(selectedPage: .constant(viewModel.pageType.currentPage), viewModel: viewModel.pageControllerViewModel)
                            Spacer()
                            NavigationLink(destination: MainSceneView(), label: {
                                Text(viewModel.skipText)
                                    .font(Font(FontStyle.normalMain.font))
                                    .foregroundColor(AppColors.actionLinkBlue)
                                    .multilineTextAlignment(.trailing)
                            })
                        }
                        .padding(.horizontal, Config.sideOffset)
                        Spacer()
                        
                        
                        
                        Button(viewModel.nextText) {
                            nextTapped()
                        }
                        .frame(width: geo.size.width - (Config.sideOffset * 2), height: 48)
                        .foregroundColor(AppColors.white)
                        .font(Font(FontStyle.button.font))
                        .background(AppColors.actionBlue)
                        .cornerRadius(Config.cornerRadius)
                        .padding(.top, 24.0)
                    }

                }
            }
        }
    }
    
    func nextTapped() {
        
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = OnboardingContnetViewModel(pageType: .first)
        OnboardingContainerView(viewModel: vm)
    }
}

//
//  OnboardingContainerView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct OnboardingContainerView: View {
    @State var viewModel: OnboardingContnetViewModel
    @State var selectedPage: Int = 1
    @State var skipTag: String? = nil
    
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
                            Text("\(selectedPage)/\(viewModel.totalSteps)")
                                .font(FontStyle.normalMain.font)
                                .foregroundColor(AppColors.white75)
                            Spacer()
                            PageControllView(selectedPage: $selectedPage, pages: viewModel.totalSteps, circleDiameter: 8.0, circleMargin: 8.0)
                            Spacer()
                            NavigationLink(destination: MainSceneView(), tag: "Skip", selection: $skipTag, label: {
                                Text(viewModel.skipText)
                                    .font(FontStyle.normalMain.font)
                                    .foregroundColor(AppColors.actionLinkBlue)
                                    .multilineTextAlignment(.trailing)
                            })
                        }
                        .padding(.horizontal, Config.sideOffset)
                        Spacer()
                        
                        TabView(selection: $selectedPage) {
                            ForEach(viewModel.content, id: \.self) { content in
                                content.tag(content.pageType.rawValue)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .animation(.easeInOut)
                        .transition(.slide)

                        NextButtonView(title: viewModel.nextText)
                            .padding(.top, 24)
                    }
                    .padding(.horizontal, Config.sideOffset)
                }
            }
        }
    }
    
    func nextTapped() {
        if selectedPage < viewModel.totalSteps {
            selectedPage = selectedPage + 1
        } else {
            skipTag = "Skip"
        }
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = OnboardingContnetViewModel(pageType: .first)
        OnboardingContainerView(viewModel: vm)
    }
}

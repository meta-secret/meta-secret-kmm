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
    @State var skipNext: Bool = false
    
    private enum Config {
        static let verticalSpacing: CGFloat = 28.0
        static let cornerRadius: CGFloat = 8.0
        static let sideOffset: CGFloat = 16.0
        static let topSpacer: CGFloat = 24.0
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                
                ZStack {
                    //BG
                    AppColors.blackBg.ignoresSafeArea()
                    Image(AppImages.Common.mainBg)
                        .resizable()
                        .ignoresSafeArea()
                    
                    //Main container
                    VStack {
                        Spacer().frame(height: Config.topSpacer)
                        
                        //Page container
                        ZStack {
                            HStack {
                                //Page counter
                                Text("\(selectedPage)/\(viewModel.totalSteps)")
                                    .font(FontStyle.normalMain.font)
                                    .foregroundColor(AppColors.white75)
                                
                                Spacer()
                                
                                //Skip button
                                Button(viewModel.skipText) {
                                    skipNext.toggle()
                                }
                                .foregroundColor(AppColors.actionLinkBlue)
                                .multilineTextAlignment(.trailing)
                                .font(FontStyle.normalMedium.font)
                                .navigationDestination(isPresented: $skipNext) {
                                    SignInView()
                                        .navigationBarBackButtonHidden(true)
                                }
                            }
                            .padding(.horizontal, Config.sideOffset)
                            
                            PageControllView(selectedPage: $selectedPage, pages: viewModel.totalSteps, circleDiameter: Config.cornerRadius, circleMargin: Config.cornerRadius)
                        }
                        
                        //Page
                        TabView(selection: $selectedPage) {
                            ForEach(viewModel.content, id: \.self) { content in
                                content.tag(content.pageType.rawValue)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .animation(.linear, value: UUID())
                        .transition(.slide)
                        
                        //Button
                        Spacer()
                            .frame(height: Config.topSpacer)
                        ActionBlueButton(title: viewModel.nextText, action: {
                            nextTapped()
                        })
                        Spacer()
                            .frame(height: Config.topSpacer)
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
            skipNext = true
        }
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = OnboardingContnetViewModel(pageType: .first)
        OnboardingContainerView(viewModel: vm)
    }
}

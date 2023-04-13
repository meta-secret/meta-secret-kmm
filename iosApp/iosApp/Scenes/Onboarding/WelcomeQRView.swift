//
//  WelcomeQRView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.04.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct WelcomeQRView: View {
    @State var viewModel: OnboardingContnetViewModel
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
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
                    
                    Spacer()
                    // Image
                    Image(uiImage: generateQRCode())
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Spacer()
                    
                    // Description
                    Text(viewModel.pageType.description)
                        .font(.custom(Avenir.medium.rawValue, size: AvenirSize.t2.rawValue))
                        .foregroundColor(AppColors.mainBlack)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                    
                    // Buttons
                    NavigationLink(destination: WelcomeAddPassword(viewModel: OnboardingContnetViewModel(pageType: .addSecret)), label: {
                        Text(viewModel.pageType.buttonTitle)
                            .frame(width: geo.size.width - Config.sideOffset * 2, height: 48)
                            .font(.custom(Avenir.bold.rawValue, size: AvenirSize.t2.rawValue))
                            .foregroundColor(AppColors.mainBlack)
                            .background(AppColors.mainOrange)
                            .cornerRadius(Config.cornerRadius)
                        
                    })
                    Spacer()
                        .frame(height: Config.verticalSpacing)
                }
            }
            .background(AppColors.mainCreame).ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
    
    func generateQRCode() -> UIImage {
        filter.message = Data(Constants.Common.appStoreLink.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct WelcomeQRView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeQRView(viewModel: OnboardingContnetViewModel(pageType: .welcomeQR))
    }
}

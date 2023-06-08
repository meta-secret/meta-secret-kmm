////
////  WelcomeView.swift
////  iosApp
////
////  Created by Dmitry Kuklin on 19.03.2023.
////  Copyright © 2023 orgName. All rights reserved.
////
//
//import SwiftUI
//import CodeScanner
//
//struct WelcomeView: View {
//    @State var viewModel: OnboardingContnetViewModel
//    @State private var isPresentingScanner = false
//    @State private var scannedURL: String = ""
//    
//    var scannerSheet: some View {
//        CodeScannerView(codeTypes: [.qr],
//                        completion: { result in
//            if case let .success(code) = result {
//                self.scannedURL = code.string
//                self.isPresentingScanner = false
//            }
//        })
//    }
//    
//    private enum Config {
//        static let verticalSpacing: CGFloat = 28.0
//        static let cornerRadius: CGFloat = 10.0
//        static let sideOffset: CGFloat = 16.0
//    }
//    
//    var body: some View {
//        NavigationView {
//            GeometryReader { geo in
//                VStack {
//                    Spacer()
//                        .frame(height: Config.verticalSpacing/2)
//                    //QR Scaner button
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            self.isPresentingScanner = true
//                        }) {
////                            Image(AppImages.qrScaner)
////                                .resizable()
////                                .aspectRatio(contentMode: .fit)
//                        }
//                        .frame(width: 40, height: 40)
//                    }
//                    .padding()
//                    Spacer()
//                        .frame(height: Config.verticalSpacing)
//                    
//                    //Main image
//                    Image(viewModel.pageType.imageName)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.vertical)
//                    
////                    Text(viewModel.pageType.title)
////                        .font(.custom(Avenir.heavy.rawValue, size: AvenirSize.h3.rawValue))
////                        .foregroundColor(AppColors.mainBlack)
////                        .multilineTextAlignment(.center)
////                    Spacer()
////                        .frame(height: Config.verticalSpacing/2)
////
////                    Text(viewModel.pageType.description)
////                        .font(.custom(Avenir.medium.rawValue, size: AvenirSize.t1.rawValue))
////                        .foregroundColor(AppColors.mainBlack)
////                        .multilineTextAlignment(.center)
////                        .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
////                    Spacer()
////
////                    NavigationLink(destination: RegisterView(viewModel: OnboardingContnetViewModel(pageType: .register)), label: {
////                        Text(viewModel.pageType.buttonTitle)
////                            .frame(width: geo.size.width - Config.sideOffset * 2, height: 48)
////                            .font(.custom(Avenir.bold.rawValue, size: AvenirSize.t2.rawValue))
////                            .foregroundColor(AppColors.mainBlack)
////                            .background(AppColors.mainOrange)
////                            .cornerRadius(Config.cornerRadius)
////
////                    })
//                    Spacer()
//                        .frame(height: Config.verticalSpacing)
//                }
//            }
////            .background(AppColors.mainCreame).ignoresSafeArea()
//        }
//        .sheet(isPresented: $isPresentingScanner) {
//            self.scannerSheet
//        }
//    }
//}
//
//struct WelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        let vm = OnboardingContnetViewModel(pageType: .first)
//        WelcomeView(viewModel: vm)
//    }
//}

//
//  SecretsView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SecretsView: View {
    private enum Config {
        static let sideOffset: CGFloat = 16.0
        static let bubbleSideOffset: CGFloat = 20.0
        static let vSpacerHeight: CGFloat = 60.0
        static let addSecretHeight: CGFloat = 344.0
        static let addDeviceHeight: CGFloat = 510.0
        static let bottomSpacer: CGFloat = 14.0
        static let animationDuration: CGFloat = 0.3
    }
    
    @State var viewModel: SecretsViewModel = SecretsViewModel()
    @State var showSecret: Bool = false
    @State private var currentItem: SecretModel? = nil
    @State var isToReload: Bool = false
    @State var showingAlert: Bool = false
    
    var body: some View {
        ZStack {
            //Bg
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            if viewModel.items.isEmpty {
                //Empty view
                VStack {
                    Spacer().frame(height: Config.vSpacerHeight)
                    EmptySecretsView()
                    Spacer()
                        
                }
            } else {
                ZStack {
                    VStack {
                        if viewModel.devicesCount < Constants.Common.neededDeviceCount {
                            //Alert Bubble
                            VStack {
                                Spacer()
                                    .frame(height: Config.vSpacerHeight)
                                AlertBubbleView()
                                    .padding(.horizontal, Config.bubbleSideOffset)
                            }
                        }
                        List {
                            ForEach(viewModel.items, id: \.id) { item in
                                Button(action: {
                                    withAnimation(.linear(duration: Config.animationDuration)) {
                                        currentItem = item as? SecretModel
                                        showSecret = true
                                    }
                                }) {
                                    SecretCellView(item: item as! SecretModel)
                                }
                                
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: Config.bottomSpacer, trailing: 0))
                        }
                        .padding(.top, (viewModel.devicesCount < Constants.Common.neededDeviceCount ? -30 : 0))
                        .scrollContentBackground(.hidden)
                    }
                    
                    if showSecret {
                        ShowSecretView(showPopUp: $showSecret, secretName: currentItem?.description ?? "", secret: currentItem?.secret ?? "")
                    }
                }
            }
        }
        .id(isToReload)
        .onAppear {
            var counter = UserDefaults.standard.value(forKey: "secretOpenCount") as! Int
            let iOSNumber = UserDefaults.standard.value(forKey: "iOSNumber") as! Int
            counter += 1
            if (counter == 3 && iOSNumber == 1) || (counter == 2 && iOSNumber == 2) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                    print("RELOAD")
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
                    print("RELOAD!!")
                    UserDefaults.standard.setValue(1, forKey: "secretCount")
                    viewModel.getContent(of: .secrets)
                    isToReload.toggle()
                })
            } else if (counter == 4 && iOSNumber == 1) || (counter == 3 && iOSNumber == 2) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    showingAlert = true
                    if iOSNumber == 2 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            showingAlert = false
                        })
                    }
                })
            }
            UserDefaults.standard.setValue(counter, forKey: "secretOpenCount")
        }
        .alert("Device Galaxy A04 request to show password.", isPresented: $showingAlert) {
            Button("Accept", role: .none) {
                showingAlert = false
            }
            Button("Discard", role: .cancel) { }
        }
    }
}

struct SecretsView_Previews: PreviewProvider {
    static var previews: some View {
        SecretsView()
    }
}

//
//  MainSceneView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 09.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MainSceneView: View {
    
    private let notify = NotificationCenter.default.publisher(for: NSNotification.Name("distributionService"))
    @StateObject var viewModel: MainSceneViewModel = MainSceneViewModel()
    
    private enum Config {
        static let sideOffset: CGFloat = 16.0
        static let addSecretHeight: CGFloat = 320.0
        static let addDeviceHeight: CGFloat = 510.0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.blackBg.ignoresSafeArea()
                Image(AppImages.Common.mainBg)
                    .resizable()
                    .ignoresSafeArea()
                
                //TabBar
                CustomTabView(action: {
                    viewModel.showActionSheet = true
                }, tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $viewModel.selectedTab) { index in
                    let type = TabType(rawValue: index) ?? .secrets
                    getTabView(type: type)
                }
                
            }
            .ignoresSafeArea()
        }
        .onReceive(notify) { (notification) in
            guard let userNotification = notification.userInfo?["type"] as? CallBackType else { return }
            switchCallback(userNotification)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Spacer()
                        .frame(height: Config.sideOffset * 2)
                    HStack {
                        Text(getNavTitle())
                            .font(FontStyle.header.font)
                            .foregroundColor(AppColors.white)
                        Spacer()
                    }
                }
            }
        }
        .navigationBarHidden(false)
        .sheet(isPresented: $viewModel.showActionSheet, onDismiss: {
            viewModel.showActionSheet = false
//            viewModel.selectedIndex = selectedIndex
        }) {
            if viewModel.selectedIndex == .Devices {
                AddDeviceView()
                    .presentationDetents([.height(Config.addDeviceHeight)])
            } else {
                AddSecretView()
                    .presentationDetents([.height(Config.addSecretHeight)])
            }
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .secrets:
            SecretsView()
        case .devices:
            DevicesView()
        case .profile:
            ProfileView()
        }
    }
}

private extension MainSceneView {
    func getNavTitle() -> String {
        switch viewModel.selectedIndex {
        case .Secrets:
            return Constants.Main.secrets
        case .Devices:
            return Constants.Main.devices
        case .Profile:
            return Constants.Main.profile
        default:
            return ""
        }
    }
    
    //MARK: - CALL BACK FROM DISTRIBUTION SERVICE
    func switchCallback(_ notification: CallBackType) {
        switch notification {
        case .Shares:
            if viewModel.selectedIndex == .Secrets {
//                firstly {
                
                self.$viewModel.getAllLocalSecrets
                        .sink { completion in
                            
                        } receiveValue: { _ in
                            if self.$viewModel.isToReDistribute {
                                self.viewModel.isToReDistribute = false
                                self.reDistribue()
                            } else {
                                self.reloadData()
                            }
                        }

//                }.catch { e in
//                    let text = (e as? MetaSecretErrorType)?.message() ?? e.localizedDescription
//                    self.alertManager.showCommonError(text)
//                    self.viewModel.isToReDistribute = false
//                }.finally {
//                    if self.viewModel.isToReDistribute {
//                        self.viewModel.isToReDistribute = false
//                        self.reDistribue()
//                    } else {
//                        self.reloadData()
//                    }
//                }
            }
        case .Devices:
            newBubble.isHidden = userService.mainVault?.pendingJoins?.count == 0
            
            if viewModel.selectedSegment == .Devices {
                firstly {
                    viewModel.getLocalVaultMembers()
                }.catch { e in
                    let text = (e as? MetaSecretErrorType)?.message() ?? e.localizedDescription
                    self.alertManager.showCommonError(text)
                    self.viewModel.isToReDistribute = false
                }.finally {
                    if self.viewModel.isToReDistribute {
                        self.viewModel.isToReDistribute = false
                        self.reDistribue()
                    } else {
                        self.reloadData()
                    }
                }
            }
        case .Claims(let decriptedSecret, let descriptionName):
            if userService.needDBRedistribution, let decriptedSecret, let descriptionName {
                viewModel.dbRedistribution(decriptedSecret, descriptionName: descriptionName)
            } else {
                break
            }
        case .Failure:
            viewModel.isToReDistribute = false
            break
        }
    }
    
}

struct MainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView()
    }
}

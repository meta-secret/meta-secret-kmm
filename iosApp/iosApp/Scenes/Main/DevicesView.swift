//
//  DevicesView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 13.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct DevicesView: View {
    @State var viewModel: DevicesViewModel = DevicesViewModel()
    
    var body: some View {
        ZStack {
            AppColors.blackBg.ignoresSafeArea()
            Image(AppImages.Common.mainBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                if viewModel.devicesCount < 3 {
                    AlertBubbleView()
                        .padding(.horizontal, 16.0)
                }
                List {
                    ForEach(viewModel.items, id: \.id) { item in
                        DevicesCellView(item: item as! DeviceModel)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView()
    }
}

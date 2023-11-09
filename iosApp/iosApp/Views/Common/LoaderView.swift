//
//  LoaderView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 26.10.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct LoaderWithDimmingView: View {
    @Binding var isLoading: Bool

    var body: some View {
        ZStack {
            if isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()

                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                EmptyView()
            }
        }
    }
}

//
//  LoaderView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 26.10.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import OSLog

struct LoaderWithDimmingView: View {
    @Binding var isLoading: Bool
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ApplicationCode")

    var body: some View {
        ZStack {
            if isLoading {
//                logger.info("LOADING...")
                Color.black.opacity(0.5)
                    .ignoresSafeArea()

                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
//                logger.info("LOADING COMPLETED")
                EmptyView()
            }
        }
    }
}

//
//  PairDeviceViewModel.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 06.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import CoreImage.CIFilterBuiltins
import UIKit
import SwiftUI

class PairDeviceViewModel: ObservableObject {
    @Service private var qrCodeManager: QRCodeManagerProtocol
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    let content: [PairPageView] = [
        PairPageView(pageType: .first),
        PairPageView(pageType: .second),
        PairPageView(pageType: .third)
    ]
    
    var pageType: PageType
    
    var totalSteps: Int {
        return PageType.allCases.count
    }
    
    init(pageType: PageType) {
        self.pageType = pageType
    }
    
    func generateQRCode() -> UIImage {
        let urlString = qrCodeManager.getQRcodeContent()
        
        filter.message = Data(urlString.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

extension PairDeviceViewModel {
    enum PageType: Int, CaseIterable {
        case first = 1
        case second
        case third
        
        var title: String? {
            switch self {
            case .first:
                return Constants.Devices.downloadApp
            case .second:
                return Constants.Devices.repeatNickName
            case .third:
                return Constants.Devices.approveConnection
            }
        }
        
        var imageName: String? {
            switch self {
            case .first:
                return ""//AppImages.stepOneIcon
            case .second:
                return ""//AppImages.stepTwoIcon
            case .third:
                return ""//AppImages.stepThreeIcon
            }
        }
    }
}

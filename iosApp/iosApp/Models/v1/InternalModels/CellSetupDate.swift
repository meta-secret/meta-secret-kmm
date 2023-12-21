//
//  CellSetupDate.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.12.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import UIKit

final class CellSetupDate {
    var title: String? = nil
    var subtitle: String? = nil
    var intValue: Int? = nil
    var status: VaultInfoStatus? = nil
    var boolValue: Bool = false
    var id: String? = nil
    var imageName: UIImage? = nil
    
    func setupCellSource(title: String? = nil, subtitle: String? = nil, intValue: Int? = nil, status: VaultInfoStatus? = nil, boolValue: Bool = false, id: String? = nil, imageName: UIImage? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.intValue = intValue
        self.status = status
        self.boolValue = boolValue
        self.id = id
        self.imageName = imageName
    }
}

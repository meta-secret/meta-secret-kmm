//
//  String+Extension.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 12.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}

//
//  KeyWidthEnum.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 29/08/25.
//

import Foundation

enum KeyWidthEnum {
    case small
    case medium
    case large
    case extraLarge
    
    func getWidth() -> CGFloat {
        switch self {
            case .small: return 80
            case .medium: return 120
            case .large: return 150
            case .extraLarge: return 200
        }
    }
}

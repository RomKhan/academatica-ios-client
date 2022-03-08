//
//  ButtonState.swift
//  Academatica
//
//  Created by Roman on 08.03.2022.
//

import Foundation
import SwiftUI

enum ButtonState {
    case active
    case disable
    
    func getColor() -> Color {
        switch self {
        case .active:
            return Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1))
        case .disable:
            return .gray
        }
    }
}

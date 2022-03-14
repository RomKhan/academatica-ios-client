//
//  ColorService.swift
//  Academatica
//
//  Created by Roman on 08.03.2022.
//

import Foundation
import SwiftUI

final class ColorService {
    enum ProblemStateColor {
        case goodAnswer
        case badAnswer
        case unmarkedAnswer
        case none
        
        func getGradient() -> LinearGradient {
            switch self {
            case .goodAnswer:
                return LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(uiColor: UIColor(red: 0 / 255.0, green: 219 / 255.0, blue: 61 / 255.0, alpha: 1)), location: 0),
                        .init(color: Color(uiColor: UIColor(red: 0 / 255.0, green: 157 / 255.0, blue: 245 / 255.0, alpha: 1)), location: 1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            case .badAnswer:
                return LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(uiColor: UIColor(red: 255 / 255.0, green: 51 / 255.0, blue: 112 / 255.0, alpha: 1)), location: 0),
                        .init(color: Color(uiColor: UIColor(red: 255 / 255.0, green: 165 / 255.0, blue: 82 / 255.0, alpha: 1)), location: 1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            case .unmarkedAnswer:
                return LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(uiColor: UIColor(red: 255 / 255.0, green: 165 / 255.0, blue: 82 / 255.0, alpha: 1)), location: 0),
                        .init(color: Color(uiColor: UIColor(red: 255 / 255.0, green: 210 / 255.0, blue: 0 / 255.0, alpha: 1)), location: 1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            case .none:
                return LinearGradient(colors: [.clear], startPoint: .leading, endPoint: .bottom)
            }
        }
        
        func getShadowColor() -> Color {
            switch self {
            case .goodAnswer:
                return Color(uiColor: UIColor(red: 0 / 255.0, green: 185 / 255.0, blue: 161 / 255.0, alpha: 1))
            case .badAnswer:
                return Color(uiColor: UIColor(red: 255 / 255.0, green: 101 / 255.0, blue: 92 / 255.0, alpha: 1))
            case .unmarkedAnswer:
                return Color(uiColor: UIColor(red: 255 / 255.0, green: 225 / 255.0, blue: 0 / 255.0, alpha: 1))
            case .none:
                return .clear
            }
        }
    }
    
    private init() {}
}

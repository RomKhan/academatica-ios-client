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
    
    private static let gradients = [
        Gradient(stops: [
            .init(color: Color(uiColor: UIColor(red: 162 / 255.0, green: 65 / 255.0, blue: 238 / 255.0, alpha: 1)), location: 0),
            .init(color: Color(uiColor: UIColor(red: 245 / 255.0, green: 173 / 255.0, blue: 89 / 255.0, alpha: 1)), location: 1)
        ]),
        Gradient(stops: [
            .init(color: Color(uiColor: UIColor(red: 65 / 255.0, green: 186 / 255.0, blue: 238 / 255.0, alpha: 1)), location: 0),
            .init(color: Color(uiColor: UIColor(red: 110 / 255.0, green: 107 / 255.0, blue: 255 / 255.0, alpha: 1)), location: 1)
        ]),
        Gradient(stops: [
            .init(color: Color(uiColor: UIColor(red: 238 / 255.0, green: 65 / 255.0, blue: 86 / 255.0, alpha: 1)), location: 0),
            .init(color: Color(uiColor: UIColor(red: 255 / 255.0, green: 143 / 255.0, blue: 107 / 255.0, alpha: 1)), location: 1)
        ]),
        Gradient(stops: [
            .init(color: Color(uiColor: UIColor(red: 54 / 255.0, green: 153 / 255.0, blue: 208 / 255.0, alpha: 1)), location: -0.1),
            .init(color: Color(uiColor: UIColor(red: 131 / 255.0, green: 33 / 255.0, blue: 147 / 255.0, alpha: 1)), location: 1)
        ]),
        Gradient(stops: [
            .init(color: Color(uiColor: UIColor(red: 131 / 255.0, green: 33 / 255.0, blue: 147 / 255.0, alpha: 1)), location: -0.1),
            .init(color: Color(uiColor: UIColor(red: 208 / 255.0, green: 119 / 255.0, blue: 54 / 255.0, alpha: 1)), location: 1)
        ])
    ]
    private init() {}
    
    static func getRandomGradient() -> Gradient {
        return gradients.randomElement()!
    }
}

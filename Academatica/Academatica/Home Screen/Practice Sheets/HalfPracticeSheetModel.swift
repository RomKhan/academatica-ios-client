//
//  HalfPracticeSheetModel.swift
//  SmartMath
//
//  Created by Roman on 18.02.2022.
//

import SwiftUI

enum PracticeSheetState {
    case byCompletedLessons, byRecomend, custom
    
    func getBackgroundGradient() -> Gradient {
        switch self {
        case .byCompletedLessons:
            return Gradient(stops: [
                .init(color:
                        Color(uiColor: UIColor(
                            red: 239 / 255.0,
                            green: 147 / 255.0,
                            blue: 126 / 255.0,
                            alpha: 1)),
                      location: 0),
                .init(color:
                        Color(uiColor: UIColor(
                            red: 170 / 255.0,
                            green: 30 / 255.0,
                            blue: 245 / 255.0,
                            alpha: 1)),
                      location: 0.7)
            ])
        case .byRecomend:
            return Gradient(stops: [
                .init(color:
                        Color(uiColor: UIColor(
                            red: 126 / 255.0,
                            green: 192 / 255.0,
                            blue: 239 / 255.0,
                            alpha: 1)),
                      location: 0.4),
                .init(color:
                        Color(uiColor: UIColor(
                            red: 30 / 255.0,
                            green: 77 / 255.0,
                            blue: 245 / 255.0,
                            alpha: 1)),
                      location: 0.7)
            ])
        case .custom:
            return Gradient(stops: [
                .init(color:
                        Color(uiColor: UIColor(
                            red: 236 / 255.0,
                            green: 140 / 255.0,
                            blue: 140 / 255.0,
                            alpha: 1)),
                      location: 0.4),
                .init(color:
                        Color(uiColor: UIColor(
                            red: 249 / 255.0,
                            green: 58 / 255.0,
                            blue: 58 / 255.0,
                            alpha: 1)),
                      location: 0.7)
            ])
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .byCompletedLessons:
            return "Практика по последним темам"
        case .byRecomend:
            return "Рекомендованная практика"
        case .custom:
            return "Пользователская практика"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .byCompletedLessons:
            return "Состоит из случайных задач по пройденным темам."
        case .byRecomend:
            return "Состоит из тем, ошибок в которых было допущено больше всего."
        case .custom:
            return "Состоит из тем, выбранных в конструкторе."
        }
    }
}

class HalfPracticeSheetModel: ObservableObject {
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1))
    ]
}

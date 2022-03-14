//
//  HalfPracticeSheetModel.swift
//  SmartMath
//
//  Created by Roman on 18.02.2022.
//

import SwiftUI

enum PracticeType {
    case recomended
    case completedLessons
    case custom
    case lesson
}

class HalfPracticeSheetModel: ObservableObject {
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1))
    ]
    
    func getBackgroundGradient(type: PracticeType) -> Gradient {
        switch type {
        case .completedLessons:
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
        case .recomended:
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
        case .lesson:
            return Gradient(stops: [
                .init(color: .red,
                      location: 0.4),
                .init(color: .red,
                      location: 0.4)
            ])
        }
    }
    
    func getTitle(type: PracticeType) -> String {
        switch type {
        case .completedLessons:
            return "Практика по последним темам"
        case .recomended:
            return "Рекомендованная практика"
        case .custom:
            return "Пользователская практика"
        case .lesson:
            return ""
        }
    }
    
    func getDescription(type: PracticeType) -> String {
        switch type {
        case .completedLessons:
            return "Состоит из случайных задач по пройденным темам."
        case .recomended:
            return "Состоит из тем, ошибок в которых было допущено больше всего."
        case .custom:
            return "Состоит из тем, выбранных в конструкторе."
        case .lesson:
            return ""
        }
    }
}

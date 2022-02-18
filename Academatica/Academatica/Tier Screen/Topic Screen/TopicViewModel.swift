//
//  TopicViewModel.swift
//  SmartMath
//
//  Created by Roman on 19.01.2022.
//

import SwiftUI

enum ClassesColors : Int {
    
    case complete = 0
    case incomplete = 1
    case unavailable = 2
    
    func getFirstColor() -> Color {
        switch self {
        case .complete:
            return Color(uiColor: UIColor(red: 113 / 255.0, green: 178 / 255.0, blue: 128 / 255.0, alpha: 1))
        case .incomplete:
            return Color(uiColor: UIColor(red: 247 / 255.0, green: 183 / 255.0, blue: 51 / 255.0, alpha: 1))
        case .unavailable:
            return Color(uiColor: UIColor(red: 237 / 255.0, green: 33 / 255.0, blue: 58 / 255.0, alpha: 1))
        }
    }
    
    func getSecondColor() -> Color {
        switch self {
        case .complete:
            return Color(uiColor: UIColor(red: 19 / 255.0, green: 78 / 255.0, blue: 94 / 255.0, alpha: 1))
        case .incomplete:
            return Color(uiColor: UIColor(red: 252 / 255.0, green: 74 / 255.0, blue: 26 / 255.0, alpha: 1))
        case .unavailable:
            return Color(uiColor: UIColor(red: 147 / 255.0, green: 41 / 255.0, blue: 30 / 255.0, alpha: 1))
        }
    }
}
class TopicViewModel: ObservableObject {
    var topicModel: TopicModel = TopicModel(id: "0", name: "Units of measurement", description: "The natural numbers are the ones you normally use to count. Learn the definition of natural numbers and their properties.", isAlgebraTopics: true, imageURL: "", isFineshed: false, amountOfClasses: 5, amoutTimeToComplete: 45)
    var classModels = [
        ClassModel(id: "1",
                   TopicId: "1",
                   TierId: "1",
                   name: "Introduction",
                   descriptionId: "What are natural numbers?",
                   expRevards: 100,
                   imageUrl: "",
                   thearyUrl: "",
                   problemNum: 10,
                   status: 0),
        ClassModel(id: "2",
                   TopicId: "1",
                   TierId: "1",
                   name: "Introduction",
                   descriptionId: "What are natural numbers?",
                   expRevards: 100,
                   imageUrl: "",
                   thearyUrl: "",
                   problemNum: 10,
                   status: 1),
        ClassModel(id: "3",
                   TopicId: "1",
                   TierId: "1",
                   name: "Introduction",
                   descriptionId: "What are natural numbers?",
                   expRevards: 100,
                   imageUrl: "",
                   thearyUrl: "",
                   problemNum: 10,
                   status: 2),
        ClassModel(id: "4",
                   TopicId: "1",
                   TierId: "1",
                   name: "Introduction",
                   descriptionId: "What are natural numbers?",
                   expRevards: 100,
                   imageUrl: "",
                   thearyUrl: "",
                   problemNum: 10,
                   status: 0)
    ]
    
    let colors = [
        Color(uiColor: UIColor(red: 162 / 255.0, green: 51 / 255.0, blue: 215 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 244 / 255.0, green: 124 / 255.0, blue: 244 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 162 / 255.0, green: 27 / 255.0, blue: 164 / 255.0, alpha: 1))
    ]
}

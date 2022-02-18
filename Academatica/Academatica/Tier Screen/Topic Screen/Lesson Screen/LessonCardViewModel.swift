//
//  LessonCardViewModel.swift
//  SmartMath
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI

class LessonCardViewModel: ObservableObject {
    var model: ClassModel = ClassModel(id: "", TopicId: "", TierId: "", name: "", descriptionId: "", expRevards: 0, imageUrl: "", thearyUrl: "", problemNum: 0, status: 0)
    var topicName: String = ""
    
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1))
    ]
    
    init(lesson: ClassModel, topicName: String) {
        model = lesson
        self.topicName = topicName
    }
}

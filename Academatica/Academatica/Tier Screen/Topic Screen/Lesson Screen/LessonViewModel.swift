//
//  LessonViewModel.swift
//  SmartMath
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI

class LessonViewModel: ObservableObject {
    var model: ClassModel = ClassModel(id: "", TopicId: "", TierId: "", name: "", descriptionId: "", expRevards: 0, imageUrl: "", thearyUrl: "", problemNum: 0, status: 0)
    var topicName: String = ""
    let colors = [
        Color(uiColor: UIColor(red: 162 / 255.0, green: 51 / 255.0, blue: 215 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 244 / 255.0, green: 124 / 255.0, blue: 244 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 162 / 255.0, green: 27 / 255.0, blue: 164 / 255.0, alpha: 1))
    ]
    
    init(lesson: ClassModel, topicName: String) {
        model = lesson
        self.topicName = topicName
    }
}

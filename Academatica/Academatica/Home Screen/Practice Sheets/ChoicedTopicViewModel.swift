//
//  ChoicedTopicViewModel.swift
//  Academatica
//
//  Created by Roman on 28.04.2022.
//

import Foundation

class ChoicedTopicViewModel: ObservableObject {
    let gradient = ColorService.getRandomGradient()
    @Published var countOfTasks: Int {
        didSet {
            model.countOfTasks = countOfTasks
            CourseService.shared.changeCountOfTasksForCustomPracticeTopic(model: model)
        }
    }
    @Published var difficulty: String {
        didSet {
            switch difficulty {
            case "Легко":
                model.difficulty = .easy
            case "Средне":
                model.difficulty = .normal
            default:
                model.difficulty = .hard
            }
            CourseService.shared.changeDifficultyForCustomPracticeTopic(model: model)
        }
    }
    
    var model: ChoicedTopicModel
    
    init(model: ChoicedTopicModel) {
        countOfTasks = model.countOfTasks
        switch model.difficulty {
        case .easy:
            difficulty = "Легко"
        case .normal:
            difficulty = "Средне"
        case .hard:
            difficulty = "Сложно"
        }
        self.model = model
    }
}

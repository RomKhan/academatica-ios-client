//
//  PracticeViewModel.swift
//  Academatica
//
//  Created by Roman on 10.03.2022.
//

import Foundation
import SwiftUI

class PracticeViewModel: ObservableObject {
    @Published var selected = 0
    @Published var badExitShow = false
    @Published var badAnswerShow = false
    @Published var showAchievements = false
    @Published var problems: [ProblemModel]
    @Published var achievements: [AchievementModel] = []
    @Published var badAnswerShowState: ServerState = .none
    @Published var classId: String?
    @Published var topicId: String?
    @Published var tagIndexSubstract: Int
    var cancel: (() -> ())
    var expReward: Int
    var practiceType: PracticeType
    
    init(type: PracticeType, problems: [ProblemModel], cancel: @escaping (() -> ()), expReward: Int, classId: String?, topicId: String?) {
        self.tagIndexSubstract = 0
        self.problems = problems
        self.cancel = cancel
        self.expReward = expReward
        self.classId = classId
        self.topicId = topicId
        practiceType = type
    }
    
    func next(isCorrect: Bool?) {
        if (isCorrect == nil || isCorrect == true && selected == problems.count + 2) {
            cancel()
        } else if (isCorrect == true && selected < problems.count + 2 &&
                   (UserStateService.shared.userState?.buoysLeft ?? 0 > 0 || practiceType != .lesson)) {
            selected += 1
        } else if (isCorrect == false && selected < problems.count && (UserStateService.shared.userState?.buoysLeft ?? 1 > 1 || practiceType != .lesson)) {
            let currentProblem = problems[selected]
            problems.append(currentProblem)
            if practiceType == .lesson {
                badAnswerShow = true
                UserStateService.shared.userBuoysPatch() { [weak self] success in
                    if success {
                        self?.badAnswerShow = false
                    } else {
                        self?.badAnswerShowState = .error
                    }
                }
            }
            CourseService.shared.lastMistakeCount += 1
            selected += 1
        } else {
            if practiceType == .lesson {
                UserStateService.shared.userBuoysPatch() { [weak self] success in
                    if success {
                        self?.badAnswerShow = false
                    } else {
                        self?.badAnswerShowState = .error
                    }
                }
                badExitShow = true
            }
        }
        tagIndexSubstract = problems.count - selected + CourseService.shared.lastMistakeCount
    }
    
    func finishPractice(achievements: [AchievementModel]) {
        self.achievements = achievements
        
        if self.achievements.count > 0 {
            showAchievements = true
        }
        
        if (selected < problems.count) {
            withAnimation {
                selected += 1
            }
        }
        print("Практика завершена")
    }
}

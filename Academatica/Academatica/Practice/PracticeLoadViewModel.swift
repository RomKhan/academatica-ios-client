//
//  PracticeLoadViewModel.swift
//  Academatica
//
//  Created by Roman on 10.03.2022.
//

import Foundation
import SwiftUI
import Combine

struct RuntimeError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}

class PracticeLoadViewModel: ObservableObject {
    @Published var serverState = ServerState.loading
    @Published var errorMessage: String = ""
    @Published var classId: String? {
        didSet {
            if let classId = classId, !problemsSet {
                serverState = .loading
                lessonPracticeLoad(id: classId)
            }
        }
    }
    @Published var topicId: String?
    @Published var practiceProblems: [ProblemModel]!
    var problemsSet: Bool = false {
        didSet {
            if !problemsSet {
                if serverState == .success {
                    serverState = .loading
                }
                
                practiceProblems = nil
            }
        }
    }
    @Published var expReward: Int = 0
    var practiceType: PracticeType
    private var cancellables = Set<AnyCancellable>()
    
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1))
    ]
    
    // Для практики по завершенным и рекомендованной.
    init(mode: PracticeType, topicId: String?) {
        practiceType = mode
        switch mode {
        case .recomended:
            recommendedPracticeLoad(topicId: topicId!)
        case .completedLessons:
            completedTopicsPracticeLoad()
        case .custom:
            customPracticeLoad()
        default:
            break
        }
        
        CourseService.shared.$practiceLoaded.sink { [weak self] newValue in
            self?.problemsSet = newValue
        }.store(in: &cancellables)
    }
    
//    // Для кастомной практики
//    init(models: [CustomPracticeTupicModel]) {
//        practiceType = .custom
//
//        CourseService.shared.$practiceLoaded.sink { [weak self] newValue in
//            self?.problemsSet = newValue
//        }.store(in: &cancellables)
//    }
    
    // Для практики по уроку
    init(lessonID: String) {
        practiceType = .lesson
        
        CourseService.shared.$practiceLoaded.sink { [weak self] newValue in
            self?.problemsSet = newValue
        }.store(in: &cancellables)
        
        CourseService.shared.$currentClass.sink { [weak self] newValue in
            self?.classId = newValue?.id
        }.store(in: &cancellables)
        
        lessonPracticeLoad(id: lessonID)
    }
    
    func recommendedPracticeLoad(topicId: String) {
        CourseService.shared.getProblems(topicId: topicId) { [weak self] success, problems in
            if success {
                self?.practiceProblems = problems
                self?.topicId = topicId
                self?.serverState = .success
                self?.expReward = 50
                CourseService.shared.practiceLoaded = true
            } else {
                self?.serverState = .error
                CourseService.shared.practiceLoaded = false
            }
        }
    }
    
    func completedTopicsPracticeLoad() {
        CourseService.shared.getProblems() { [weak self] success, problems in
            if success {
                self?.practiceProblems = problems
                self?.serverState = .success
                self?.expReward = 50
                CourseService.shared.practiceLoaded = true
            } else {
                self?.serverState = .error
                CourseService.shared.practiceLoaded = false
            }
        }
    }
    
    func customPracticeLoad() {
        CourseService.shared.getProblemsForCustomPractice() { [weak self] success, problems in
            if success {
                self?.practiceProblems = problems
                self?.serverState = .success
                self?.expReward = 50
                CourseService.shared.practiceLoaded = true
            } else {
                self?.serverState = .error
                CourseService.shared.practiceLoaded = false
            }
        }
    }
    
    func lessonPracticeLoad(id: String) {
        if practiceType != .lesson {return}
        guard let buoysCount = UserStateService.shared.userState?.buoysLeft else {
            serverState = .error
            return
        }
        
        guard buoysCount > 0 else {
            serverState = .error
            errorMessage = "У вас нет спасательных кругов"
            return
        }
        
        CourseService.shared.getProblems(classId: id) { [weak self] success, problems in
            if success {
                self?.practiceProblems = problems
                self?.classId = id
                self?.serverState = .success
                self?.expReward = 100
                CourseService.shared.practiceLoaded = true
            } else {
                self?.serverState = .error
                CourseService.shared.practiceLoaded = false
            }
        }
    }
}

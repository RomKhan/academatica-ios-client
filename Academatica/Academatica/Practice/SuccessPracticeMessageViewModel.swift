//
//  SuccessPracticeMessageViewModel.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import Foundation
import Combine

class SuccessPracticeMessageViewModel: ObservableObject {
    @Published var serverState: ServerState = .none
    var cancelFunc: (([AchievementModel]) -> ())
    var exitFunc: (() -> ())
    var dismissFunc: (() -> ())
    @Published var expCount: Int = 0
    @Published var buoysAdded: Bool = false
    @Published var achievements: [AchievementModel] = []
    var classId: String?
    var topicId: String?
    var mistakeCount: Int
    var practiceType: PracticeType
    
    private var cancellables = Set<AnyCancellable>()
    
    init(exit: @escaping (() -> ()), cancelFunc: @escaping (([AchievementModel]) -> ()), classId: String?, topicId: String?, mistakeCount: Int, practiceType: PracticeType, dismiss: @escaping (() -> ())) {
        self.cancelFunc = cancelFunc
        self.exitFunc = exit
        self.classId = classId
        self.topicId = topicId
        self.mistakeCount = mistakeCount
        self.practiceType = practiceType
        self.dismissFunc = dismiss
        
        CourseService.shared.$lastExpReward.sink { [weak self] newValue in
            self?.expCount = newValue
        }.store(in: &cancellables)
        
        CourseService.shared.$lastBuoysAdded.sink { [weak self] newValue in
            self?.buoysAdded = newValue
        }.store(in: &cancellables)
        
        CourseService.shared.$lastAchievements.sink { [weak self] newValue in
            self?.achievements = newValue
        }.store(in: &cancellables)
    }
    
    func finish() {
        serverState = .loading
        if let classId = classId {
            CourseService.shared.finishClass(classId: classId, mistakeCount: mistakeCount) { [weak self] success in
                if !success {
                    self?.serverState = .error
                } else {
                    self?.serverState = .none
                }
            }
        } else {
            switch practiceType {
            case .recomended:
                CourseService.shared.finishRecommendedPractice(topicId: topicId!, mistakeCount: mistakeCount) { [weak self] success in
                    if !success {
                        self?.serverState = .error
                    } else {
                        self?.cancelFunc([])
                        self?.serverState = .none
                    }
                }
            case .completedLessons:
                CourseService.shared.finishRandomPractice(mistakeCount: mistakeCount) { [weak self] success in
                    if !success {
                        self?.serverState = .error
                    } else {
                        self?.cancelFunc([])
                        self?.serverState = .none
                    }
                }
            default:
                break
            }
        }
    }
    
    func cancel() {
        switch practiceType {
        case .recomended:
            cancelFunc([])
            dismissFunc()
        case .completedLessons:
            cancelFunc([])
            dismissFunc()
        case .custom:
            cancelFunc([])
            dismissFunc()
        case .lesson:
            cancelFunc(achievements)
        }
    }
}

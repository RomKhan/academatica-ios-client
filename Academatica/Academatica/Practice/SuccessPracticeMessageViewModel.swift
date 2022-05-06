//
//  SuccessPracticeMessageViewModel.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import Foundation
import Combine
import AVFAudio

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
    var mistakeCount: Int = 0
    var practiceType: PracticeType
    
    private var audioPlayer: AVAudioPlayer!
    private var cancellables = Set<AnyCancellable>()
    
    init(exit: @escaping (() -> ()), cancelFunc: @escaping (([AchievementModel]) -> ()), classId: String?, topicId: String?, practiceType: PracticeType, dismiss: @escaping (() -> ())) {
        self.cancelFunc = cancelFunc
        self.exitFunc = exit
        self.classId = classId
        self.topicId = topicId
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
        
        CourseService.shared.$lastMistakeCount.sink { [weak self] newValue in
            self?.mistakeCount = newValue
        }.store(in: &cancellables)
    }
    
    func finish() {
        serverState = .loading
        
        try! AVAudioSession.sharedInstance().setCategory(.playback)
        let sound = Bundle.main.path(forResource: "success", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!), fileTypeHint: "mp3")
        audioPlayer.volume = 0.7
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
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
            case .custom:
                CourseService.shared.finishCustomPractice { [weak self] success in
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
            if (achievements.count == 0) {
                dismissFunc()
            }
        }
    }
}

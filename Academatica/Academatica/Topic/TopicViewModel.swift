//
//  TopicViewModel.swift
//  SmartMath
//
//  Created by Roman on 19.01.2022.
//

import SwiftUI
import Combine

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
    @Published var topicModel: TopicModel = TopicModel(id: "0", name: "sample", description: "desc", isAlgebraTopic: true, imageUrl: nil, isComplete: false, isUnlocked: true, completionRate: 0, classCount: 1)
    @Published var classes: [ClassModel] = []
    @Published var selectedClass: ClassModel = ClassModel(id: "0", name: "classname", description: "desc", expReward: -1, imageUrl: nil, theoryUrl: URL(string: "https://google.com")!, problemNum: 10, topicName: "topicname", isComplete: false, isUnlocked: true)
    
    private var cancellables = Set<AnyCancellable>();
    
    public init() {
        CourseService.shared.$currentTopic.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.topicModel = newValue
                self?.loadClasses()
            }
        }.store(in: &cancellables)
        
        CourseService.shared.$classes.sink { [weak self] newValue in
            self?.classes = newValue
        }.store(in: &cancellables)
        
        loadClasses()
    }
    
    func loadClasses() {
        CourseService.shared.getClasses(topicId: topicModel.id)
    }
    
    let colors = [
        Color(uiColor: UIColor(red: 162 / 255.0, green: 51 / 255.0, blue: 215 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 244 / 255.0, green: 124 / 255.0, blue: 244 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 162 / 255.0, green: 27 / 255.0, blue: 164 / 255.0, alpha: 1))
    ]
}

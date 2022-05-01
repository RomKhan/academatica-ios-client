//
//  CustomPracticeSheetViewModel.swift
//  SmartMath
//
//  Created by Roman on 18.02.2022.
//

import SwiftUI
import Combine

struct CustomPracticeTupicModel {
    
}
class CustomPracticeSheetViewModel: ObservableObject {
    @Published var tierCardModels: [TierModel] = []
    @Published var selectedTier: TierModel?
    @Published var choicedTopics: [ChoicedTopicModel] = []
    @Published var serverState: ServerState = .loading
    
    private var cancellables = Set<AnyCancellable>();
    
    init() {
        CourseService.shared.getCustomPracticeTiers {[weak self] isSuccess in
            if isSuccess {
                self?.serverState = .success
            } else {
                self?.serverState = .error
            }
        }
        CourseService.shared.choicedCustomPracticeTopics.removeAll()
        
        CourseService.shared.$customPracticeTiers.sink { [weak self] newValue in
            self?.tierCardModels = newValue
        }.store(in: &cancellables)
        
        CourseService.shared.$choicedCustomPracticeTopics.sink { [weak self] newValue in
            self?.choicedTopics = newValue
        }.store(in: &cancellables)
    }
    
    func removeTopicFromTheSelected(offsets: IndexSet) {
        CourseService.shared.removeTopicFromTheSelected(offsets: offsets)
    }
}

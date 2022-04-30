//
//  CustomPracticeCardStackViewModel.swift
//  Academatica
//
//  Created by Roman on 27.04.2022.
//

import Foundation
import Combine

class CustomPracticeCardStackViewModel : ObservableObject {
    @Published var cardData: [CustomPracticeTopicModel] = []
    @Published var cardStackStatus: ServerState = .loading
    private let tierId: String
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(tierId: String) {
        self.tierId = tierId
        CourseService.shared.$customPracticeTopics.sink { [weak self] newValue in
            var newArray: [CustomPracticeTopicModel] = []
            newArray.append(contentsOf: newValue[tierId] ?? [])

            self?.cardData = newArray
        }.store(in: &cancellables)
    }
    
    func choiceTopic(index: Int) {
        CourseService.shared.choiceTopicForCustomPractice(tierId: tierId, index: index)
    }
}

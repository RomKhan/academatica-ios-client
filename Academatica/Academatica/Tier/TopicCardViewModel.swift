//
//  File.swift
//  SmartMath
//
//  Created by Roman on 10.01.2022.
//

import SwiftUI
import Combine

class TopicCardViewModel: ObservableObject {
    let gradient: Gradient = ColorService.getRandomGradient()
    
    @Published var topicModel: TopicModel?
    
    private var cancellables = Set<AnyCancellable>();
    
    init(topicId: String) {
        CourseService.shared.$topics.sink { [weak self] newValue in
            self?.topicModel = newValue.first(where: { value in
                value.id == topicId
            })
        }.store(in: &cancellables)
    }
}

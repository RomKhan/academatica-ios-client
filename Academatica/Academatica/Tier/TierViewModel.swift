//
//  File.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI
import Combine

class TierViewModel: ObservableObject {
    @Published var selectedTierIndex: Int = 0
    
    @Published var tierCardModels: [TierModel] = []
    @Published var countOfAlgebraTopics: Int = 0
    @Published var countOfGeometryTopics: Int = 0
    @Published var serverState = ServerState.none
    @Published var topicModels: [TopicModel] = []
    
    private var cancellables = Set<AnyCancellable>();
    
    public init() {
        CourseService.shared.$tiers.sink { [weak self] newValue in
            self?.tierCardModels = newValue
            self?.loadTopics()
        }.store(in: &cancellables)
        
        CourseService.shared.$topics.sink { [weak self] newValue in
            self?.topicModels = newValue
            self?.countOfAlgebraTopics = newValue.filter { $0.isAlgebraTopic }.count
            self?.countOfGeometryTopics = newValue.filter { !$0.isAlgebraTopic }.count
            self?.serverState = .success
        }.store(in: &cancellables)
    }
    
    func loadData() {
        CourseService.shared.getTiers()
    }
    
    func loadTopics() {
        topicModels.removeAll()
        serverState = .loading
        
        if (selectedTierIndex >= tierCardModels.count) {
            return
        }
        
        CourseService.shared.getTopics(tierId: tierCardModels[selectedTierIndex].id)
    }
}

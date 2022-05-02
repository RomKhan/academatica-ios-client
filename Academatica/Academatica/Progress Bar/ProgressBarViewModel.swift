//
//  ProgressBarViewModel.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI
import Combine

enum ProgressBarType {
    case topic, tier
}
class ProgressBarViewModel: ObservableObject {
    @Published var percentages: CGFloat = 0
    private var cancellables = Set<AnyCancellable>();
    
    init(percentages: CGFloat) {
        self.percentages = percentages
    }
    
    init(_ type: ProgressBarType) {
        switch type {
        case .topic:
            CourseService.shared.$currentTopic.sink { [weak self] newValue in
                self?.percentages = 0
                if let newValue = newValue {
                    self?.percentages = CGFloat(newValue.completionRate) / 100
                }
            }.store(in: &cancellables)
        case .tier:
            CourseService.shared.$currentTier.sink { [weak self] newValue in
                self?.percentages = 0
                if let newValue = newValue {
                    self?.percentages = CGFloat(newValue.completionRate) / 100
                }
            }.store(in: &cancellables)
        }
    }
}

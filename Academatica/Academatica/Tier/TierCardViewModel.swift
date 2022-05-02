//
//  TierCardViewModel.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI
import Combine

class TierCardViewModel: ObservableObject {
    @Published var model: TierModel?
    
    private var cancellables = Set<AnyCancellable>();
    
    init(tierId: String) {
        CourseService.shared.$tiers.sink { [weak self] newValue in
            self?.model = newValue.first(where: { value in
                value.id == tierId
            })
        }.store(in: &cancellables)
    }
}

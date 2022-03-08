//
//  BuoysLeftCounterViewModel.swift
//  Academatica
//
//  Created by Roman on 08.03.2022.
//

import Foundation
import Combine

class BuoysLeftCounterViewModel : ObservableObject {
    @Published var amount: Int? = CourseServises.shared.buoysCount.value
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        CourseServises.shared.buoysCount
            .receive(on: DispatchQueue.main)
            .sink { [self] values in
                self.amount = values
            }
            .store(in: &cancellables)
    }
    
    func counterUpdate() {
        CourseServises.buoysCountUpdate()
    }
}

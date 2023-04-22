//
//  BuoysLeftCounterViewModel.swift
//  Academatica
//
//  Created by Roman on 08.03.2022.
//

import Foundation
import Combine

class BuoysLeftCounterViewModel : ObservableObject {
    @Published var amount: Int?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        counterUpdate()
        
        UserStateService.shared.$userState.sink { [weak self] newValue in
            if newValue?.buoysLeft != self?.amount {
                self?.amount = newValue?.buoysLeft
            }
        }.store(in: &cancellables)
    }
    
    func counterUpdate() {
        UserStateService.shared.updateUserState()
    }
}

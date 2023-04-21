//
//  AcadematicaAppViewModel.swift
//  Academatica
//
//  Created by Roman on 08.03.2022.
//

import Foundation
import Combine

class AcadematicaAppViewModel: ObservableObject {
    @Published var isAuthorized: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserService.shared.isAuthorized
            .receive(on: DispatchQueue.main)
            .sink { [self] values in
                self.isAuthorized = values
            }
            .store(in: &cancellables)
    }
}

//
//  LoadLeadBoardsViewModel.swift
//  Academatica
//
//  Created by Roman on 13.03.2022.
//

import Foundation
import Combine

class LoadLeadBoardsViewModel: ObservableObject {
    @Published var league: League?
    @Published var serverState = ServerState.loading
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserStateService.shared.$userLeaderboardState.sink { [weak self] newValue in
            if newValue != nil {
                self?.serverState = .success
                self?.league = newValue?.league
            } else {
                self?.serverState = .error
                self?.league = nil
            }
        }.store(in: &cancellables)
        
        tryLoadLeaderboardState()
    }
    
    func tryLoadLeaderboardState() {
        serverState = .loading
        UserStateService.shared.updateUserLeaderboardState()
    }
}

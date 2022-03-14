//
//  ProfileViewModel.swift
//  SmartMath
//
//  Created by Roman on 13.01.2022.
//

import SwiftUI
import Combine

class ProfileViewModel : ObservableObject {
    @Published var achievementsOfRightStack: [AchievementModel] = []
    @Published var achievementsOfLeftStack: [AchievementModel] = []
    @Published var leagueState: LeaderboardStateModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserStateService.shared.$userLeaderboardState.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.leagueState = newValue
            }
        }.store(in: &cancellables)
        
        UserStateService.shared.$userAchievements.sink { [weak self] newValue in
            self?.achievementsOfRightStack.removeAll()
            self?.achievementsOfLeftStack.removeAll()
            
            if let newValue = newValue {
                for i in (0 ..< newValue.count / 2) {
                    self?.achievementsOfRightStack.append(newValue[i])
                }
                
                for i in (newValue.count / 2 ..< newValue.count) {
                    self?.achievementsOfLeftStack.append(newValue[i])
                }
            }
        }.store(in: &cancellables)
        
        dataUpdate()
    }
    
    func dataUpdate() {
        getAchievements()
        getLeagueState()
    }
    
    func getLeagueState() {
        UserStateService.shared.updateUserLeaderboardState()
    }
    
    func getAchievements() {
        UserStateService.shared.loadUserAchievements()
    }
}

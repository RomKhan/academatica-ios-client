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
    @Published var serverState: ServerState = .none
    @Published var userModel: UserModel?
    
    private var otherUser: Bool = false
    private var userId: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init(userId: String) {
        UserService.shared.$otherUserModel.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.userModel = newValue
            }
        }.store(in: &cancellables)
        
        UserStateService.shared.$otherUserLeaderboardState.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.leagueState = newValue
            }
        }.store(in: &cancellables)
        
        UserStateService.shared.$otherUserAchievements.sink { [weak self] newValue in
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
        
        self.userId = userId
        self.otherUser = true
        
        dataUpdate()
    }
    
    init() {
        UserService.shared.$userModel.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.userModel = newValue
            }
        }.store(in: &cancellables)
        
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
        serverState = .loading
        
        if otherUser {
            UserService.shared.otherUserSetup(userId: userId)
        }
        
        getAchievements()
        getLeagueState()
        serverState = .none
    }
    
    func getLeagueState() {
        if !otherUser {
            UserStateService.shared.updateUserLeaderboardState()
        } else {
            UserStateService.shared.loadOtherUserLeaderboardState(userId: userId)
        }
    }
    
    func getAchievements() {
        if !otherUser {
            UserStateService.shared.loadUserAchievements()
        } else {
            UserStateService.shared.loadOtherUserLeaderboardState(userId: userId)
        }
    }
}

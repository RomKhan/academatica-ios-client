//
//  LeadBoardsViewModel.swift
//  SmartMath
//
//  Created by Roman on 16.01.2022.
//

import SwiftUI
import Combine

struct LeadBoardUserModel: Identifiable, Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let profilePic: URL?
    let username: String
    let expThisWeek: Int
    let rank: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "userId", firstName, lastName, username, profilePic, expThisWeek, rank
    }
}

class LeadBoardsViewModel: ObservableObject {
    @Published var leadboardUsers: [LeadBoardUserModel] = []
    @Published var userPlace: Int = 1
    @Published var isLoadingUsers = false
    var userLeague: League = .none
    @Published var colors: [Color] = []
    var pageCounter = 1
    var ableToLoad: Bool = true
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserStateService.shared.$userLeaderboardState.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.userPlace = newValue.rank
                self?.colors = newValue.league.getTheme()
                self?.userLeague = newValue.league
                self?.loadMoreUsers()
            }
        }.store(in: &cancellables)
    }
    
    func loadMoreUsers() {
        if ableToLoad {
            isLoadingUsers = true
            UserStateService.shared.loadLeaderboard(league: userLeague, page: pageCounter) { [weak self] entries in
                if entries.count > 0 {
                    for entry in entries {
                        let ids = self?.leadboardUsers.map { user in
                            return user.id
                        }
                        
                        if !(ids?.contains(entry.id) ?? true) {
                            self?.leadboardUsers.append(entry)
                        }
                    }
                    
                    self?.pageCounter += 1
                } else {
                    self?.ableToLoad = false
                }
                self?.isLoadingUsers = false
            }
        } else {
            isLoadingUsers = false
        }
    }
}

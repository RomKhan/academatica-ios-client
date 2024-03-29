//
//  UserStateService.swift
//  Academatica
//
//  Created by Vladislav on 11.03.2022.
//

import Foundation
import Alamofire
import SwiftUI

struct UserStateModel: Decodable {
    let buoysLeft: Int
    let daysStreak: Int
}

struct AchievementsListModel: Decodable {
    let achievements: [AchievementModel]
}

struct LeaderboardStateModel: Decodable, Equatable {
    let league: League
    let rank: Int
}

struct LeaderboardPageModel: Decodable {
    let leaderboard: [LeadBoardUserModel]
}

enum League: String, Decodable {
    case none = "none"
    case bronze = "bronze"
    case silver = "silver"
    case gold = "gold"
    
    func getName() -> String {
        switch self {
        case .none:
            return "Не определена"
        case .bronze:
            return "Бронза"
        case .silver:
            return "Серебро"
        case .gold:
            return "Золото"
        }
    }
    
    func getTheme() -> [Color] {
        switch self {
        case .none:
            return [
                .black,
                .black,
                .black,
                .black
            ]
        case .bronze:
            return [
                Color(uiColor: UIColor(red: 220 / 255.0, green: 207 / 255.0, blue: 195 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 167 / 255.0, green: 87 / 255.0, blue: 42 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 220 / 255.0, green: 207 / 255.0, blue: 195 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 167 / 255.0, green: 87 / 255.0, blue: 42 / 255.0, alpha: 1))
            ]
        case .silver:
            return [
                Color(uiColor: UIColor(red: 203 / 255.0, green: 217 / 255.0, blue: 206 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 19 / 255.0, green: 78 / 255.0, blue: 94 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 203 / 255.0, green: 217 / 255.0, blue: 206 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 19 / 255.0, green: 78 / 255.0, blue: 94 / 255.0, alpha: 1))
            ]
        case .gold:
            return [
                Color(uiColor: UIColor(red: 255 / 255.0, green: 168 / 255.0, blue: 0 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 255 / 255.0, green: 107 / 255.0, blue: 0 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 255 / 255.0, green: 185 / 255.0, blue: 80 / 255.0, alpha: 1)),
                Color(uiColor: UIColor(red: 242 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1))
            ]
        }
    }
}

final class UserStateService: ObservableObject {
    public static let shared = UserStateService()
    private var userService = UserService.shared
    private var cacheHelper = CacheService.shared
    private let host = AppConfiguration.environment.apiURL
    
    @Published var userState: UserStateModel?
    @Published var userLeaderboardState: LeaderboardStateModel?
    @Published var otherUserLeaderboardState: LeaderboardStateModel?
    @Published var userAchievements: [AchievementModel]?
    @Published var otherUserAchievements: [AchievementModel]?
    
    private init() { }
    
    func updateUserState() {
        guard let userId = userService.userId else {
            return
        }
        
        if let cache = cacheHelper.cachedUserState {
            self.userState = cache
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("Отправлен запрос : " + host + "/api/users/" + userId + "/state")
        AF.request(host + "/api/users/" + userId + "/state", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: UserStateModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    print("--> USER STATE LOAD ERROR: " + String(describing: error))
                } else {
                    print("--> USER STATE LOAD ERROR: UNKNOWN")
                }
                return
            }
            
            self?.userState = result
            self?.cacheHelper.cachedUserState = self?.userState
        }
    }
    
    func updateUserLeaderboardState() {
        guard let userId = userService.userId else {
            return
        }
        
        if let cache = cacheHelper.cachedUserLeaderboardState {
            self.userLeaderboardState = cache
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("Отправлен запрос : " + host + "/api/leaderboard/" + userId)
        AF.request(host + "/api/leaderboard/" + userId, method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: LeaderboardStateModel.self) { [weak self] response in
            guard let result = response.value else {
                if let responseCode = response.error?.responseCode {
                    print("--> USER LEADERBOARD STATE LOAD ERROR: " + String(responseCode))
                } else {
                    print("--> USER LEADERBOARD STATE LOAD ERROR: UNKNOWN")
                }
                return
            }
            
            self?.userLeaderboardState = result
            self?.cacheHelper.cachedUserLeaderboardState = self?.userLeaderboardState
        }
    }
    
    func loadOtherUserLeaderboardState(userId: String) {
        if let cache = cacheHelper.cachedOtherUserLeaderboardState {
            self.otherUserLeaderboardState = cache
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("Отправлен запрос : " + host + "/api/leaderboard/" + userId)
        AF.request(host + "/api/leaderboard/" + userId, method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: LeaderboardStateModel.self) { [weak self] response in
            guard let result = response.value else {
                if let responseCode = response.error?.responseCode {
                    print("--> USER LEADERBOARD STATE LOAD ERROR: " + String(responseCode))
                } else {
                    print("--> USER LEADERBOARD STATE LOAD ERROR: UNKNOWN")
                }
                return
            }
            
            self?.otherUserLeaderboardState = result
            self?.cacheHelper.cachedOtherUserLeaderboardState = self?.otherUserLeaderboardState
        }
    }
    
    func loadUserAchievements() {
        guard let userId = userService.userId else {
            return
        }
        
        if let cache = cacheHelper.cachedUserAchievements {
            self.userAchievements = cache
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("Отправлен запрос : " + host + "/api/users/" + userId + "/achievements")
        AF.request(host + "/api/users/" + userId + "/achievements", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: AchievementsListModel.self) { [weak self] response in
            guard let result = response.value else {
                if let responseCode = response.error?.responseCode {
                    print("--> USER ACHIEVEMENTS LOAD ERROR: " + String(responseCode))
                } else {
                    print("--> USER ACHIEVEMENTS LOAD ERROR: UNKNOWN")
                }
                return
            }
            
            self?.userAchievements = result.achievements
            self?.cacheHelper.cachedUserAchievements = self?.userAchievements
        }
    }
    
    func loadOtherUserAchievements(userId: String) {
        if let cache = cacheHelper.cachedOtherUserAchievements {
            self.otherUserAchievements = cache
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("Отправлен запрос : " + host + "/api/users/" + userId + "/achievements")
        AF.request(host + "/api/users/" + userId + "/achievements", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: AchievementsListModel.self) { [weak self] response in
            guard let result = response.value else {
                if let responseCode = response.error?.responseCode {
                    print("--> USER ACHIEVEMENTS LOAD ERROR: " + String(responseCode))
                } else {
                    print("--> USER ACHIEVEMENTS LOAD ERROR: UNKNOWN")
                }
                return
            }
            
            self?.otherUserAchievements = result.achievements
            self?.cacheHelper.cachedOtherUserAchievements = result.achievements
        }
    }
    
    func userBuoysPatch(completion: @escaping (Bool) -> Void) {
        guard let userId = userService.userId else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("Отправлен запрос : " + host + "/api/users/" + userId + "/buoys")
        AF.request(host + "/api/users/" + userId + "/buoys", method: .patch, headers: headers, interceptor: APIRequestInterceptor.shared).responseString { [weak self] response in
            if let error = response.error {
                completion(false)
                print("--> USER BUOYS PATCH ERROR: " + error.localizedDescription)
            }
            
            completion(true)
            self?.cacheHelper.clearUserState()
            self?.updateUserState()
        }
    }
    
    func loadLeaderboard(league: League, page: Int, completion: @escaping ([LeadBoardUserModel]) -> ()) {
        if league == .none {
            completion([])
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("Отправлен запрос : " + host + "/api/leaderboard/" + league.rawValue + "?page=" + String(page))
        AF.request(host + "/api/leaderboard/" + league.rawValue + "?page=" + String(page), method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: LeaderboardPageModel.self) { response in
            guard let result = response.value else {
                if let error = response.error {
                    print("--> LEADERBOARD LOAD ERROR: " + String(describing: error))
                }
                completion([])
                return
            }
            
            completion(result.leaderboard)
        }
    }
}

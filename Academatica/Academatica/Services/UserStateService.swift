//
//  UserStateService.swift
//  Academatica
//
//  Created by Vladislav on 11.03.2022.
//

import Foundation
import Alamofire

struct AchievementsListModel: Decodable {
    let achievements: [AchievementModel]
}

struct LeaderboardStateModel: Decodable, Equatable {
    let league: League
    let rank: Int
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
}

final class UserStateService: ObservableObject {
    public static let shared = UserStateService()
    private var userService = UserService.shared
    private let host = "https://news-platform.ru"
    
    @Published var userState: UserStateModel?
    @Published var userLeaderboardState: LeaderboardStateModel?
    @Published var userAchievements: [AchievementModel]?
    
    private init() { }
    
    func updateUserState() {
        guard let userId = userService.userId else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/users/" + userId + "/state", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: UserStateModel.self) { [weak self] response in
            guard let result = response.value else {
                if let responseCode = response.error?.responseCode {
                    print("--> USER STATE LOAD ERROR: " + String(responseCode))
                } else {
                    print("--> USER STATE LOAD ERROR: UNKNOWN")
                }
                return
            }
            
            self?.userState = result
        }
    }
    
    func updateUserLeaderboardState() {
        guard let userId = userService.userId else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
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
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func loadUserAchievements() {
        guard let userId = userService.userId else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
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
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func userBuoysPatch(completion: @escaping (Bool) -> Void) {
        guard let userId = userService.userId else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/users/" + userId + "/buoys", method: .patch, headers: headers, interceptor: APIRequestInterceptor.shared).responseString { [weak self] response in
            if let error = response.error {
                completion(false)
                print("--> USER BUOYS PATCH ERROR: " + error.localizedDescription)
            }
            
            completion(true)
            self?.updateUserState()
        }
    }
}

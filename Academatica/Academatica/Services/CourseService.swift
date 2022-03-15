//
//  CourseServices.swift
//  Academatica
//
//  Created by Roman on 08.03.2022.
//

import Foundation
import Combine
import Alamofire

enum ServerState {
    case none
    case loading
    case success
    case error
}

struct UpcomingClassModel: Decodable, Identifiable {
    let id: String
    let topicId: String
    let tierId: String
    let name: String
    let description: String
    let expReward: Int
    let imageUrl: URL?
    let theoryUrl: URL
    let problemNum: Int
    let isAlgebraClass: Bool
    let topicName: String
    let classNumber: Int
    let topicClassCount: Int
}

struct UpcomingClassListModel: Decodable {
    let upcomingClasses: [UpcomingClassModel]
}

struct TiersListModel: Decodable {
    let tiers: [TierModel]
}

struct TopicListModel: Decodable {
    let topics: [TopicModel]
}

struct ClassListModel: Decodable {
    let classes: [ClassModel]
}

struct ProblemListModel: Decodable {
    let problems: [ProblemModel]
}

struct ClassAchievementModel: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let description: String
    let imageUrl: URL
    
    private enum CodingKeys: CodingKey {
        case name, description, imageUrl
    }
}

struct ClassPracticeResultModel: Decodable {
    let exp: Int
    let achievements: [ClassAchievementModel]
}

struct PracticeResultModel: Decodable {
    let exp: Int
    let buoyAdded: Bool
}

struct RecommendedTopicModel: Decodable {
    let id: String
    let name: String
    let description: String
    let imageUrl: URL?
    let isAlgebraTopic: Bool
}

struct RecommendedTopicResponseModel: Decodable {
    let recommendedTopic: RecommendedTopicModel
}

struct CompletedTopicListModel: Decodable {
    let topics: [RecommendedTopicModel]
}

final class CourseService: ObservableObject {
    @Published var upcomingClasses: [UpcomingClassModel] = []
    @Published var tiers: [TierModel] = []
    @Published var topics: [TopicModel] = []
    @Published var classes: [ClassModel] = []
    @Published var currentTier: TierModel?
    @Published var currentTopic: TopicModel?
    @Published var currentClass: ClassModel?
    @Published var recommendedTopic: RecommendedTopicModel?
    @Published var completedTopicCount: Int = 0
    @Published var lastExpReward: Int = 0
    @Published var lastBuoysAdded: Bool = false
    @Published var lastAchievements: [AchievementModel] = []
    @Published var practiceLoaded: Bool = false
    
    private let host = "https://news-platform.ru"
    static let shared = CourseService()
    
    private init() {}
    
    func getUpcomingLessons() {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/classes/upcoming", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: UpcomingClassListModel.self) { [weak self] response in
            guard let result = response.value else {
                return
            }
            
            self?.upcomingClasses.removeAll()
            self?.upcomingClasses.append(contentsOf: result.upcomingClasses)
        }
    }
    
    func getTiers() {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/tiers", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: TiersListModel.self) { [weak self] response in
            guard let result = response.value else {
                return
            }
            
            self?.tiers.removeAll()
            self?.tiers.append(contentsOf: result.tiers)
        }
    }
    
    func getTopics(tierId: String) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/tiers/" + tierId, method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: TopicListModel.self) { [weak self] response in
            guard let result = response.value else {
                return
            }
            
            self?.topics.removeAll()
            self?.topics.append(contentsOf: result.topics)
        }
    }
    
    func getClasses(topicId: String) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/topics/" + topicId, method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: ClassListModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    print(error.localizedDescription)
                }
                return
            }
            
            self?.classes.removeAll()
            self?.classes.append(contentsOf: result.classes)
        }
    }
    
    func getCompletedTopicsCount() {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/topics/completed", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: CompletedTopicListModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    print(error.localizedDescription)
                }
                return
            }
            
            self?.completedTopicCount = result.topics.count
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func getRecommendedPracticeTopic() {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/practice/recommended", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: RecommendedTopicResponseModel.self) { [weak self] response in
            self?.recommendedTopic = response.value?.recommendedTopic
        }
    }
    
    func getProblems(classId: String, completion: @escaping (Bool, [ProblemModel]) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/classes/" + classId + "/problems", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: ProblemListModel.self) { response in
            guard let result = response.value else {
                if let error = response.error {
                    print("PROBLEM LOAD ERROR: " + error.localizedDescription)
                    completion(false, [])
                }
                return
            }
            
            completion(true, result.problems)
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func getProblems(topicId: String, completion: @escaping (Bool, [ProblemModel]) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/practice/topic/problems?topicId=" + topicId, method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: ProblemListModel.self) { response in
            guard let result = response.value else {
                if let error = response.error {
                    print("PROBLEM LOAD ERROR: " + error.localizedDescription)
                    print(String(describing: error))
                    completion(false, [])
                }
                return
            }
            
            completion(true, result.problems)
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func getProblems(completion: @escaping (Bool, [ProblemModel]) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/practice/completed/problems", method: .get, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: ProblemListModel.self) { response in
            guard let result = response.value else {
                if let error = response.error {
                    print("PROBLEM LOAD ERROR: " + error.localizedDescription)
                    completion(false, [])
                }
                return
            }
            
            completion(true, result.problems)
        }
    }
    
    func finishClass(classId: String, mistakeCount: Int, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters = [
            "mistakeCount": mistakeCount
        ]
        
        AF.request(host + "/api/course/classes/" + classId + "/finish", method: .post, parameters: parameters,  encoding: JSONEncoding.default, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: ClassPracticeResultModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    print("RESULTS LOAD ERROR: " + error.localizedDescription)
                    completion(false)
                    self?.lastExpReward = 0
                    self?.lastAchievements = []
                }
                return
            }
            
            self?.lastExpReward = result.exp
            self?.lastAchievements = result.achievements.map { value in
                return AchievementModel(name: value.name, description: value.description, imageUrl: value.imageUrl, achievedAmount: 1)
            }
            completion(true)
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func finishRecommendedPractice(topicId: String, mistakeCount: Int, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "mistakeCount": mistakeCount,
            "isCustomPractice": false,
            "topicId": topicId
        ]
        
        AF.request(host + "/api/course/practice/finish", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: PracticeResultModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    print("RESULTS LOAD ERROR: " + error.localizedDescription)
                    completion(false)
                    self?.lastExpReward = 0
                    self?.lastBuoysAdded = false
                }
                return
            }
            
            self?.lastExpReward = result.exp
            self?.lastBuoysAdded = result.buoyAdded
            completion(true)
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func finishRandomPractice(mistakeCount: Int, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "mistakeCount": mistakeCount,
            "isCustomPractice": false
        ]
        
        AF.request(host + "/api/course/practice/finish", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: PracticeResultModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    print("RESULTS LOAD ERROR: " + error.localizedDescription)
                    completion(false)
                    self?.lastExpReward = 0
                    self?.lastBuoysAdded = false
                }
                return
            }
            
            self?.lastExpReward = result.exp
            self?.lastBuoysAdded = result.buoyAdded
            completion(true)
        }
    }
}

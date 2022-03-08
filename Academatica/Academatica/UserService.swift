//
//  UserService.swift
//  Academatica
//
//  Created by Roman on 07.03.2022.
//

import Foundation
import Combine
import SwiftUI


struct UserModel : Identifiable {
    var id: UUID?
    var email: String?
    var userName: String?
    var firstName: String?
    var lastName: String?
    var registereAt: String?
    var profilePicURL: URL?
    var experiencePoints: Int?
    var expPointsThisWeek: Int?
    var level: Int?
    var expUntilTheNextLevel: Int?
}

final class UserService {
    var isAuthorized = CurrentValueSubject<Bool, Never>(false)
    public static let shared = UserService()
    private enum UserDefaultsKeys: String {
        case refreshToken
    }
    
    static var refreshToken: String! {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.refreshToken.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = UserDefaultsKeys.refreshToken.rawValue
            if let value = newValue {
                defaults.set(value, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var accessToken: String! {
        get {
            return refreshToken
        }
    }
    
    static var userModel = UserModel()
    static var daysStreak: Int?
    
    
    private init() {}
    
    static func logIn(userName: String?, password: String?) {
        UserService.shared.isAuthorized.value = true
        refreshToken = "dsfg"
    }
    
    
    static func registerStart(firstName: String?, lastName: String?, userName: String?, email: String?, password: String?) {
        
    }
    
    static func registerConfirm(code: String?) {
        refreshToken = "dsfg"
        UserService.shared.isAuthorized.value = true
    }
    
    static func userSetup() {
        getUserId()
        userModel.email = "ivanov@gmail.com"
        userModel.userName = "ivanov"
        userModel.firstName = "Иван"
        userModel.lastName = "Сидоров"
        userModel.registereAt = "дата"
        userModel.profilePicURL = URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg")
        userModel.experiencePoints = 100
        userModel.expPointsThisWeek = 12
        userModel.level = 1
        userModel.expUntilTheNextLevel = 100
    }
    
    static func getUserId() {
        userModel.id = UUID()
    }
    
//    static func apiUsersIdGet(model: UserModel) {
//        if (userModel.id != nil) {
//            userModel.firstName = "Ваня"
//            userModel.lastName = "Сидоров"
//
//        }
//    }
}

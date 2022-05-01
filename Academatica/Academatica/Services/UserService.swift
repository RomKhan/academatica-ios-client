//
//  UserService.swift
//  Academatica
//
//  Created by Roman on 07.03.2022.
//

import Foundation
import Combine
import SwiftUI
import Alamofire

struct UserModel: Identifiable {
    var id: String
    var email: String
    var username: String
    var firstName: String
    var lastName: String
    var profilePicUrl: URL?
    var exp: Int
    var expThisWeek: Int
    var level: Int
    let levelName: String
    var expLevelCap: Int
    var maxLevelReached: Bool
    
    func getLevelName() -> String {
        switch levelName {
        case "newcomer":
            return "Новичок"
        case "apprentice":
            return "Ученик"
        case "fast learner":
            return "Опытный"
        case "enthusiast":
            return "Энтузиаст"
        case "matter expert":
            return "Эксперт"
        case "virtuose":
            return "Виртуоз"
        case "calculator":
            return "Калькулятор"
        default:
            return "Неизвестный"
        }
    }
}

struct UserProfileModel: Decodable {
    let email: String
    let username: String
    let firstName: String
    let lastName: String
    let profilePicUrl: URL?
    let exp: Int
    let expThisWeek: Int
    let level: Int
    let levelName: String
    let expLevelCap: Int
    let maxLevelReached: Bool
}

struct CodeCheckResponseModel: Decodable {
    let success: Bool
}

struct CredentialsChangeResponseModel: Decodable {
    let success: Bool
    let error: String?
}

struct UserActivityModel: Decodable {
    let activityMatrix: [String: Int]
}

final class UserService: ObservableObject {
    @Published var authorizationNotification: String = ""
    var isAuthorized = CurrentValueSubject<Bool, Never>(false)
    let keychainHelper: KeychainService = KeychainService.shared
    private let host = "https://news-platform.ru"
    public static let shared = UserService()
    private var userSetupInProgress: Bool = false
    
    var refreshToken: String? {
        get {
            return keychainHelper.read(service: "refresh_token", account: "Academatica.Api", type: String.self)
        }
        set {
            if let value = newValue {
                keychainHelper.save(value, service: "refresh_token", account: "Academatica.Api")
            } else {
                keychainHelper.delete(service: "refresh_token", account: "Academatica.Api")
            }
        }
    }
    
    var accessToken: String? {
        get {
            return keychainHelper.read(service: "access_token", account: "Academatica.Api", type: String.self)
        } set {
            if let value = newValue {
                keychainHelper.save(value, service: "access_token", account: "Academatica.Api")
            } else {
                keychainHelper.delete(service: "access_token", account: "Academatica.Api")
            }
        }
    }
    
    var userId: String? {
        get {
            return keychainHelper.read(service: "user_id", account: "Academatica.Api", type: String.self)
        } set {
            if let value = newValue {
                keychainHelper.save(value, service: "user_id", account: "Academatica.Api")
            } else {
                keychainHelper.delete(service: "user_id", account: "Academatica.Api")
            }
        }
    }
    
    @Published var userModel: UserModel?
    @Published var otherUserModel: UserModel?
    var daysStreak: Int?
    
    private init() {}
    
    func logIn(email: String?, password: String?, completion: @escaping (Bool, String?) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters = [
            "grant_type": "password",
            "username": email,
            "password": password,
            "client_id": "Academatica.App",
            "scope": "Academatica.Api offline_access openid"
        ];
        
        AF.request(host + "/connect/token", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: APIRequestInterceptor.shared).responseDecodable(of: TokenModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    completion(false, error.failureReason)
                }
                
                completion(false, "Неизвестная ошибка")
                self?.logOff()
                return
            }
            
            self?.accessToken = result.accessToken
            self?.refreshToken = result.refreshToken
            
            self?.loadUserInfo(completion: completion)
        }
    }
    
    func loadUserInfo(completion: @escaping (Bool, String?) -> Void) {
        if accessToken == nil {
            completion(false, "Неизвестная ошибка")
            logOff()
            return
        }
        
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer " + accessToken!
        ]
        
        AF.request(host + "/connect/userinfo", method: .get, headers: headersInfo, interceptor: APIRequestInterceptor.shared).responseDecodable(of: OpenIDModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    completion(false, error.failureReason)
                }
                return
            }
            
            self?.userId = result.sub
            self?.isAuthorized.value = true
            
            completion(true, nil)
        }
    }
    
    func logOff() {
        print(Thread.callStackSymbols)
        isAuthorized.value = false
        accessToken = nil
        refreshToken = nil
        userId = nil
        userModel = nil
    }
    
    func signUp(firstName: String?, lastName: String?, userName: String?, email: String?, password: String?, confirmPassword: String?, profilePic: UIImage?, completion: @escaping (Bool, String?) -> Void) {
        let parameters = [
            "email": email,
            "username": userName,
            "password": password,
            "confirmPassword": confirmPassword,
            "firstName": firstName,
            "lastName": lastName
        ];
        
        AF.upload(multipartFormData: { multipartFormData in
            if let profilePic = profilePic {
                multipartFormData.append(profilePic.jpegData(compressionQuality: 0.8)!, withName: "profilePicture", fileName: "img.jpg", mimeType: "image/jpg")
            }
            for (key, value) in parameters {
                if let value = value {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, to: host + "/connect/register", interceptor: APIRequestInterceptor.shared).responseString { response in
            let success: Bool = response.response?.statusCode == 200
            let message: String? = success ? nil : response.value
            completion(success, message)
        }
    }
    
    func userSetup() {
        guard let userId = userId else {
            logOff()
            return
        }
        
        let url = host + "/api/users/" + userId
        
        AF.request(url, method: .get, interceptor: APIRequestInterceptor.shared).responseDecodable(of: UserProfileModel.self) { [weak self] response in
            guard let result = response.value else {
                if let error = response.error {
                    print(String(describing: error))
                }
                return
            }
            
            self?.userModel = UserModel(
                id: userId,
                email: result.email,
                username: result.username,
                firstName: result.firstName,
                lastName: result.lastName,
                profilePicUrl: result.profilePicUrl,
                exp: result.exp,
                expThisWeek: result.expThisWeek,
                level: result.level,
                levelName: result.levelName,
                expLevelCap: result.expLevelCap,
                maxLevelReached: result.maxLevelReached
            )
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func otherUserSetup(userId: String) {
        let url = host + "/api/users/" + userId
        
        AF.request(url, method: .get, interceptor: APIRequestInterceptor.shared).responseDecodable(of: UserProfileModel.self) { [weak self] response in
            guard let result = response.value else {
                if response.error != nil {
                    self?.logOff()
                }
                return
            }
            
            self?.otherUserModel = UserModel(
                id: userId,
                email: result.email,
                username: result.username,
                firstName: result.firstName,
                lastName: result.lastName,
                profilePicUrl: result.profilePicUrl,
                exp: result.exp,
                expThisWeek: result.expThisWeek,
                level: result.level,
                levelName: result.levelName,
                expLevelCap: result.expLevelCap,
                maxLevelReached: result.maxLevelReached
            )
        }
    }
    
    func sendEmailConfirmationCode() {
        guard let userId = userId else {
            logOff()
            return
        }
        
        AF.request(host + "/api/users/" + userId + "/email/confirmation-code", method: .post, interceptor: APIRequestInterceptor.shared).responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func sendPasswordConfirmationCode() {
        guard let userId = userId else {
            logOff()
            return
        }
        
        AF.request(host + "/api/users/" + userId + "/password/confirmation-code", method: .post, interceptor: APIRequestInterceptor.shared).responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func checkEmailConfirmationCode(_ confirmationCode: String, completion: @escaping (Bool) -> Void) {
        guard let userId = userId else {
            logOff()
            return
        }
        
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/users/" + userId + "/email/confirmation-code?code=" + confirmationCode, method: .get, headers: headersInfo, interceptor: APIRequestInterceptor.shared).responseDecodable(of: CodeCheckResponseModel.self) { response in
            guard let result = response.value else {
                completion(false)
                return
            }
            
            completion(result.success)
        }
    }
    
    func checkPasswordConfirmationCode(_ confirmationCode: String, completion: @escaping (Bool) -> Void) {
        guard let userId = userId else {
            logOff()
            return
        }
        
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/users/" + userId + "/password/confirmation-code?code=" + confirmationCode, method: .get, headers: headersInfo, interceptor: APIRequestInterceptor.shared).responseDecodable(of: CodeCheckResponseModel.self) { response in
            guard let result = response.value else {
                completion(false)
                return
            }
            
            completion(result.success)
        }
    }
    
    func changeUserEMail(confirmationCode: String, newEmail: String, completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else {
            logOff()
            return
        }
        
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters = [
            "EMail": newEmail,
            "ConfirmationCode": confirmationCode
        ]
        
        AF.request(host + "/api/users/" + userId + "/email", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headersInfo, interceptor: APIRequestInterceptor.shared).responseDecodable(of: CredentialsChangeResponseModel.self) { response in
            guard let result = response.value else {
                if let error = response.error {
                    print(String(describing: error))
                }
                completion(false, nil)
                return
            }
            
            completion(result.success, result.error)
        }
    }
    
    func changeUserPassword(oldPassword: String, newPassword: String, newPasswordConfirm: String,completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else {
            logOff()
            return
        }
        
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters = [
            "OldPassword": oldPassword,
            "NewPassword": newPassword,
            "ConfirmNewPassword": newPasswordConfirm
        ]
        
        AF.request(host + "/api/users/" + userId + "/password", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headersInfo, interceptor: APIRequestInterceptor.shared).responseDecodable(of: CredentialsChangeResponseModel.self) { response in
            guard let result = response.value else {
                if let error = response.error {
                    print(String(describing: error))
                }
                completion(false, nil)
                return
            }
            
            completion(result.success, result.error)
        }.responseString { response in
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func changeUsername(newUsername: String, completion: @escaping (Bool) -> Void) {
        guard let userId = userId else {
            logOff()
            return
        }
        
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters = [
            "username": newUsername
        ]
        
        AF.request(host + "/api/users/" + userId + "/username", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headersInfo, interceptor: APIRequestInterceptor.shared).response { [weak self] response in
            if let error = response.error {
                print(String(describing: error))
                completion(false)
            } else {
                completion(true)
                self?.userSetup()
            }
        }
    }
    
    func changeFirstName(newFirstName: String, completion: @escaping (Bool) -> Void) {
        guard let userId = userId else {
            logOff()
            return
        }
        
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters = [
            "firstName": newFirstName
        ]
        
        AF.request(host + "/api/users/" + userId + "/firstname", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headersInfo, interceptor: APIRequestInterceptor.shared).response { response in
            if let error = response.error {
                print(String(describing: error))
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func changeLastName(newLastName: String, completion: @escaping (Bool) -> Void) {
        guard let userId = userId else {
            logOff()
            return
        }
        
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters = [
            "lastName": newLastName
        ]
        
        AF.request(host + "/api/users/" + userId + "/lastname", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headersInfo, interceptor: APIRequestInterceptor.shared).response { response in
            if let error = response.error {
                print(String(describing: error))
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func changeImage(newImage: UIImage?, completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else {
            completion(false, "")
            return
        }
        AF.upload(multipartFormData: { multipartFormData in
            if let profilePic = newImage {
                multipartFormData.append(profilePic.jpegData(compressionQuality: 0.8)!, withName: "formFile", fileName: "img.jpg", mimeType: "image/jpg")
            }
        }, to: host + "/api/users/" + userId + "/image", interceptor: APIRequestInterceptor.shared).responseString { response in
            let success: Bool = response.response?.statusCode == 200
            let message: String? = success ? nil : response.value
            completion(success, message)
        }
    }
    
    func loadActivity(completion: @escaping ([String: Int]?) -> Void) {
        let headersInfo: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(host + "/api/course/activity", method: .get, headers: headersInfo, interceptor: APIRequestInterceptor.shared).responseDecodable(of: UserActivityModel.self) { response in
            guard let result = response.value else {
                if let error = response.error {
                    print(String(describing: error))
                }
                completion(nil)
                return
            }
            
            completion(result.activityMatrix)
        }
    }
}

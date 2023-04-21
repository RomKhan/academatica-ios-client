//
//  APIRequestInterceptor.swift
//  Academatica
//
//  Created by Vladislav on 10.03.2022.
//

import Foundation
import Alamofire

struct TokenModel: Decodable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

struct OpenIDModel: Decodable {
    let sub: String
}

final class APIRequestInterceptor: RequestInterceptor, RequestRetrier {
    private let userService: UserService = UserService.shared
    private let apiURL = AppConfiguration.environment.apiURL
    public static let shared: APIRequestInterceptor = APIRequestInterceptor()

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(apiURL + "/connect") == false else {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        
        if let accessToken = userService.accessToken {
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")

            completion(.success(urlRequest))
        }
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }

        if let refreshToken = userService.refreshToken {
            refreshTokens(refreshToken) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let tokens):
                    self.userService.accessToken = tokens.accessToken
                    self.userService.refreshToken = tokens.refreshToken
                    // After updating the token we can safely retry the original request.
                    completion(.retry)
                case .failure(let error):
                    // print(error.localizedDescription)
                    self.userService.logOff()
                }
            }
        }
    }
    
    private func refreshTokens(_ refreshToken: String, completion: @escaping (Result<TokenModel, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters = [
            "grant_type": "refresh_token",
            "client_id": "Academatica.App",
            "scope": "Academatica.Api offline_access openid",
            "refresh_token": refreshToken
        ];
        
        AF.request(apiURL + "/connect/token", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: self).responseDecodable(of: TokenModel.self) { response in
            guard let result = response.value else {
                if let error = response.error {
                    completion(.failure(error))
                }
                return
            }
            
            completion(.success(result))
        }
    }
}
